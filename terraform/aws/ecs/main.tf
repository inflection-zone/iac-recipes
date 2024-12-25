module "vpc" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/vpc"
  # source = "../../../../../templates/terraform/modules/aws/vpc"

  vpc-properties = local.vpc-properties
}

module "ecr-repository" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/ecr"
  # source = "../../../../../templates/terraform/modules/aws/ecr"

  ecr-properties = local.ecr-properties
}

module "rds" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/rds"
  # source = "../../../../../templates/terraform/modules/aws/rds"

  rds-properties          = local.rds-properties
  bastion-host-properties = local.bastion-host-properties

  vpc-id              = local.vpc-id
  vpc-public-subnets  = local.vpc-public-subnets
  vpc-private-subnets = local.vpc-private-subnets

  depends_on = [
    module.vpc
  ]
}

module "s3" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/s3"
  # source = "../../../../../templates/terraform/modules/aws/s3"

  s3-properties = local.s3-properties
}

resource "aws_s3_object" "env-file" {
  bucket = local.s3-bucket-id
  key    = local.s3-properties.s3-object-key
  source = local.s3-properties.s3-object-source-path
  etag   = filemd5(local.s3-properties.s3-object-source-path)  
}

module "load-balancer" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/load-balancer"
  # source = "../../../../../templates/terraform/modules/aws/load-balancer"

  load-balancer-properties = local.load-balancer-properties
  vpc-id                   = local.vpc-id
  vpc-public-subnets       = local.vpc-public-subnets
}

# module "route53" {
#   source = "github.com/sahilphule/templates/terraform/modules/aws/route53"
#   # source = "../../../../../templates/terraform/modules/aws/route53"

#   route53-properties = local.route53-properties

#   depends_on = [
#     module.load-balancer
#   ]
# }

module "ecs" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/ecs"
  # source = "../../../../../templates/terraform/modules/aws/ecs"

  ecs-properties           = local.ecs-properties
  ecs-container-definition = local.ecs-container-definition
  target-group-arn         = local.load-balancer-tg-arn
  load-balancer-sg-id      = local.load-balancer-sg-id

  vpc-id             = local.vpc-id
  vpc-public-subnets = local.vpc-public-subnets

  depends_on = [
    module.s3,
    module.rds
  ]
}