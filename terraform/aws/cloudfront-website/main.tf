module "s3-bucket" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/s3-bucket"
  # source = "../../../../../../../../templates/devops-templates/terraform/modules/aws/s3-bucket"

  s3-bucket-properties = local.s3-bucket-properties
  s3-bucket-policy     = local.s3-bucket-policy
}

module "acm-route53" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/acm-route53"
  # source = "../../../../../../../../templates/devops-templates/terraform/modules/aws/acm-route53"

  acm-properties          = local.acm-properties
  route53-zone-properties = local.route53-zone-properties
}

module "cloudfront" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/cloudfront"
  # source = "../../../../../../../../templates/devops-templates/terraform/modules/aws/cloudfront"

  cloudfront-properties          = local.cloudfront-properties
  s3-bucket-regional-domain-name = local.s3-bucket-regional-domain-name
  acm-certificate-arn            = local.acm-certificate-arn

  depends_on = [
    module.s3-bucket,
    module.acm-route53
  ]
}

module "route53-record" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/route53-record"
  # source = "../../../../../../../../templates/devops-templates/terraform/modules/aws/route53-record"

  route53-record-properties = local.route53-record-properties

  depends_on = [
    module.cloudfront
  ]
}
