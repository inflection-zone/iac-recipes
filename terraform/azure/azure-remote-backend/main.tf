module "resource-group" {
  source = "github.com/inflection-templates/terraform-modules/azure/resource-group"
  # source = "../../../../../../../../templates/terraform-modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "storage" {
  source = "github.com/inflection-templates/terraform-modules/azure/storage"
  # source = "../../../../../../../../templates/terraform-modules/azure/storage"

  resource-group-properties = local.resource-group-properties
  storage-properties        = local.storage-properties
  vnet-public-subnet-id     = local.vnet-public-subnet-id

  depends_on = [
    module.resource-group
  ]
}
