module "vpc" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/vpc"
  # source = "../../../../../../templates/terraform/modules/aws/vpc"

  vpc-properties = local.vpc-properties
}

module "ec2" {
  source = "github.com/sahilphule/templates/terraform/modules/aws/ec2"
  # source = "../../../../../../templates/terraform/modules/aws/ec2"

  ec2-properties = local.ec2-properties

  vpc-id             = local.vpc-id
  vpc-public-subnets = local.vpc-public-subnets

  depends_on = [
    module.vpc
  ]
}

# module "eip" {
#   # source = "github.com/sahilphule/templates/terraform/modules/aws/eip"
#   source = "../../../../../../templates/terraform/modules/aws/eip"

#   eip-properties = local.eip-properties

#   depends_on = [
#     module.ec2
#   ]
# }

# module "acm-route53" {
#   # source = "github.com/sahilphule/templates/terraform/modules/aws/acm-route53"
#   source = "../../../../../../templates/terraform/modules/aws/acm-route53"

#   acm-properties          = local.acm-properties
#   route53-zone-properties = local.route53-zone-properties
# }

# module "load-balancer" {
#   # source = "github.com/sahilphule/templates/terraform/modules/aws/load-balancer"
#   source = "../../../../../../templates/terraform/modules/aws/load-balancer"

#   load-balancer-properties = local.load-balancer-properties
#   vpc-id                   = local.vpc-id
#   vpc-public-subnets       = local.vpc-public-subnets
#   acm-certificate-arn      = local.acm-certificate-arn

#   depends_on = [
#     module.vpc
#   ]
# }

# resource "aws_alb_target_group_attachment" "tg-attachment" {
#   target_group_arn = local.load-balancer-tg-arn
#   target_id        = local.ec2-instance-id

#   depends_on = [
#     module.ec2,
#     module.load-balancer
#   ]
# }

# module "route53-record" {
#   # source = "github.com/sahilphule/templates/terraform/modules/aws/route53-record"
#   source = "../../../../../../templates/terraform/modules/aws/route53-record"

#   route53-record-properties = local.route53-record-properties

#   depends_on = [
#     module.ec2,
#     module.load-balancer
#   ]
# }