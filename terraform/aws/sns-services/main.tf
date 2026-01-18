module "sns" {
  source = "github.com/inflection-templates/terraform-modules/aws/sns"
  # source = "../../../../../../../../templates/terraform-modules/aws/sns"

  sns-properties = local.sns-properties
}

module "null-resource" {
  source = "github.com/inflection-templates/terraform-modules/aws/null-resource"
  # source = "../../../../../../../../templates/terraform-modules/aws/null-resource"

  null-resource-properties = local.null-resource-properties
}
