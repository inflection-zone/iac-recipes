module "cloudwatch" {
  # source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/cloudwatch"
  source = "../../../../../../../../../templates/devops-templates/terraform/modules/aws/cloudwatch"

  cloudwatch-properties = local.cloudwatch-properties
}

module "lambda" {
  # source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/lambda"
  source = "../../../../../../../../../templates/devops-templates/terraform/modules/aws/lambda"

  lambda-properties = local.lambda-properties
}

module "eventbridge" {
  # source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/eventbridge"
  source = "../../../../../../../../../templates/devops-templates/terraform/modules/aws/eventbridge"

  eventbridge-properties = local.eventbridge-properties
}
