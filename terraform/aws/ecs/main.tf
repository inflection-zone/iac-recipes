module "vpc" {
  source = "github.com/inflection-templates/terraform-modules/aws/vpc"
  # source = "../../../../../../../../templates/terraform-modules/aws/vpc"

  vpc-properties = local.vpc-properties
}

module "ecr-repository" {
  source = "github.com/inflection-templates/terraform-modules/aws/ecr"
  # source = "../../../../../../../../templates/terraform-modules/aws/ecr"

  ecr-properties = local.ecr-properties
}

module "s3" {
  source = "github.com/inflection-templates/terraform-modules/aws/s3"
  # source = "../../../../../../../../templates/terraform-modules/aws/s3"

  s3-properties    = local.s3-properties
  s3-bucket-policy = local.s3-bucket-policy
}

module "rds" {
  source = "github.com/inflection-templates/terraform-modules/aws/rds"
  # source = "../../../../../../../../templates/terraform-modules/aws/rds"

  rds-properties          = local.rds-properties
  bastion-host-properties = local.bastion-host-properties
  vpc-id                  = local.vpc-id
  vpc-public-subnets      = local.vpc-public-subnets
  vpc-private-subnets     = local.vpc-private-subnets
}

module "cloudwatch" {
  source = "github.com/inflection-templates/terraform-modules/aws/cloudwatch"
  # source = "../../../../../../../../templates/terraform-modules/aws/cloudwatch"

  cloudwatch-properties = local.cloudwatch-properties
}

# module "acm-route53" {
#   source = "github.com/inflection-templates/terraform-modules/aws/acm-route53"
#   # source = "../../../../../../../../templates/terraform-modules/aws/acm-route53"

#   acm-properties          = local.acm-properties
#   route53-zone-properties = local.route53-zone-properties
# }

module "load-balancer" {
  source = "github.com/inflection-templates/terraform-modules/aws/load-balancer"
  # source = "../../../../../../../../templates/terraform-modules/aws/load-balancer"

  load-balancer-properties = local.load-balancer-properties
  vpc-id                   = local.vpc-id
  vpc-public-subnets       = local.vpc-public-subnets
  acm-certificate-arn      = local.acm-certificate-arn
}

# module "route53-record" {
#   source = "github.com/inflection-templates/terraform-modules/aws/route53-record"
#   # source = "../../../../../../../../templates/terraform-modules/aws/route53-record"

#   route53-record-properties = local.route53-record-properties
# }

module "ecs" {
  source = "github.com/inflection-templates/terraform-modules/aws/ecs"
  # source = "../../../../../../../../templates/terraform-modules/aws/ecs"

  ecs-properties            = local.ecs-properties
  ecs-container-definitions = local.ecs-container-definitions
  lb-target-group-arn       = local.lb-target-group-arn
  lb-security-group-id      = local.lb-security-group-id

  vpc-id             = local.vpc-id
  vpc-public-subnets = local.vpc-public-subnets
}
