module "vpc" {
  source = "github.com/inflection-templates/terraform-modules/aws/vpc"
  # source = "../../../../../../../../templates/terraform-modules/aws/vpc"

  vpc-properties = local.vpc-properties
}

module "ec2" {
  source = "github.com/inflection-templates/terraform-modules/aws/ec2"
  # source = "../../../../../../../../templates/terraform-modules/aws/ec2"

  ec2-properties     = local.ec2-properties
  vpc-id             = local.vpc-id
  vpc-public-subnets = local.vpc-public-subnets
}

module "eip" {
  source = "github.com/inflection-templates/terraform-modules/aws/eip"
  # source = "../../../../../../../../templates/terraform-modules/aws/eip"

  eip-properties = local.eip-properties
}

module "acm-route53" {
  source = "github.com/inflection-templates/terraform-modules/aws/acm-route53"
  # source = "../../../../../../../../templates/terraform-modules/aws/acm-route53"

  acm-properties          = local.acm-properties
  route53-zone-properties = local.route53-zone-properties
}

module "load-balancer" {
  source = "github.com/inflection-templates/terraform-modules/aws/load-balancer"
  # source = "../../../../../../../../templates/terraform-modules/aws/load-balancer"

  load-balancer-properties = local.load-balancer-properties
  vpc-id                   = local.vpc-id
  vpc-public-subnets       = local.vpc-public-subnets
  acm-certificate-arn      = local.acm-certificate-arn
}

resource "aws_alb_target_group_attachment" "tg-attachment" {
  target_group_arn = local.lb-target-group-arn
  target_id        = local.ec2-instance-id
}

module "route53-record" {
  source = "github.com/inflection-templates/terraform-modules/aws/route53-record"
  # source = "../../../../../../../../templates/terraform-modules/aws/route53-record"

  route53-record-properties = local.route53-record-properties
}
