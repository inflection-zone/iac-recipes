module "s3" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/s3"
  # source = "../../../../../../../../templates/devops-templates/terraform/modules/aws/s3"

  s3-properties    = local.s3-properties
  s3-bucket-policy = local.s3-bucket-policy
}

module "dynamodb" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/dynamodb"
  # source = "../../../../../../../../templates/devops-templates/terraform/modules/aws/dynamodb"

  dynamodb-properties      = local.dynamodb-properties
  dynamodb-resource-policy = local.dynamodb-resource-policy
}
