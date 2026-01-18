module "cloudwatch" {
  source = "github.com/inflection-templates/terraform-modules/aws/cloudwatch"
  # source = "../../../../../../../../../templates/terraform-modules/aws/cloudwatch"

  cloudwatch-properties = local.cloudwatch-properties
}

module "lambda" {
  source = "github.com/inflection-templates/terraform-modules/aws/lambda"
  # source = "../../../../../../../../../templates/terraform-modules/aws/lambda"

  lambda-properties = local.lambda-properties
  vpc-id            = local.vpc-id
  vpc-subnet-id     = local.vpc-subnet-id
}

module "eventbridge" {
  source = "github.com/inflection-templates/terraform-modules/aws/eventbridge"
  # source = "../../../../../../../../../templates/terraform-modules/aws/eventbridge"

  eventbridge-properties = local.eventbridge-properties
}
