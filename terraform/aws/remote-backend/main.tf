module "s3-bucket" {
  # source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/s3-bucket"
  source = "../../../../../../../templates/terraform/modules/aws/s3-bucket"

  s3-bucket-properties = local.s3-bucket-properties
  s3-bucket-policy     = local.s3-bucket-policy
}

module "dynamodb" {
  # source = "github.com/inflection-templates/devops-templates/terraform/modules/aws/dynamodb"
  source = "../../../../../../../templates/terraform/modules/aws/dynamodb"

  dynamodb-properties      = local.dynamodb-properties
  dynamodb-resource-policy = local.dynamodb-resource-policy
}