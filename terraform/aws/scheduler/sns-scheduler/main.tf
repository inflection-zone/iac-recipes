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

module "sns" {
  #   source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/sns"
  source = "../../../../../../../../../templates/devops-templates/terraform/modules/aws/sns"

  sns-properties = local.sns-properties
}

# Allow EventBridge to invoke Lambda
resource "aws_lambda_permission" "lambda-permission" {
  count = local.lambda-permission.lambda-permission-count

  function_name = local.lambda-permission.lambda-permission-function-name[count.index]
  statement_id  = local.lambda-permission.lambda-permission-statement-id
  action        = local.lambda-permission.lambda-permission-action
  principal     = local.lambda-permission.lambda-permission-principal
  source_arn    = local.lambda-permission.lambda-permission-source-arn
}

module "eventbridge" {
  # source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/eventbridge"
  source = "../../../../../../../../../templates/devops-templates/terraform/modules/aws/eventbridge"

  eventbridge-properties = local.eventbridge-properties
}
