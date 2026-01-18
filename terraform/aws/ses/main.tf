module "ses" {
  source = "github.com/inflection-templates/terraform-modules/aws/ses"
  # source = "../../../../../../../../templates/terraform-modules/aws/ses"

  ses-properties = local.ses-properties
}

module "null-resource" {
  source = "github.com/inflection-templates/terraform-modules/aws/null-resource"
  # source = "../../../../../../../../templates/terraform-modules/aws/null-resource"

  null-resource-properties = local.null-resource-properties
}
