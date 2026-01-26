module "resource-group" {
  source = "github.com/inflection-templates/terraform-modules/azure/resource-group"
  # source = "../../../../../../../../templates/terraform-modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "virtual-network" {
  source = "github.com/inflection-templates/terraform-modules/azure/virtual-network"
  # source = "../../../../../../../../templates/terraform-modules/azure/virtual-network"

  resource-group-properties  = local.resource-group-properties
  virtual-network-properties = local.virtual-network-properties

  depends_on = [
    module.resource-group
  ]
}

module "acr" {
  source = "github.com/inflection-templates/terraform-modules/azure/acr"
  # source = "../../../../../../../../templates/terraform-modules/azure/acr"

  resource-group-properties = local.resource-group-properties
  acr-properties            = local.acr-properties

  depends_on = [
    module.resource-group
  ]
}

module "mysql-flexible" {
  source = "github.com/inflection-templates/terraform-modules/azure/mysql-flexible"
  # source = "../../../../../../../../templates/terraform-modules/azure/mysql-flexible"

  resource-group-properties = local.resource-group-properties
  mysql-flexible-properties = local.mysql-flexible-properties
  vnet-id                   = local.vnet-id
  vnet-name                 = local.vnet-name

  depends_on = [
    module.virtual-network
  ]
}

module "storage" {
  source = "github.com/inflection-templates/terraform-modules/azure/storage"
  # source = "../../../../../../../../templates/terraform-modules/azure/storage"

  resource-group-properties = local.resource-group-properties
  storage-properties        = local.storage-properties
  vnet-public-subnet-id     = local.vnet-subnet-ids[0]

  depends_on = [
    module.virtual-network
  ]
}

module "container-apps-setup" {
  source = "github.com/inflection-templates/terraform-modules/azure/container-apps-setup"
  # source = "../../../../../../../../templates/terraform-modules/azure/container-apps-setup"

  resource-group-properties      = local.resource-group-properties
  container-app-setup-properties = local.container-app-setup-properties
  vnet-infrastructure-subnet-id = local.vnet-subnet-id

  depends_on = [
    module.virtual-network
  ]
}

module "container-apps" {
  source = "github.com/inflection-templates/terraform-modules/azure/container-apps"
  # source = "../../../../../../../../templates/terraform-modules/azure/container-apps"

  resource-group-properties    = local.resource-group-properties
  container-app-properties     = local.container-app-properties
  container-app-environment-id = local.container-app-environment-id
  acr-login-server             = local.acr-login-server
  acr-admin-username           = local.acr-admin-username
  acr-admin-password           = local.acr-admin-password

  depends_on = [
    module.container-apps-setup
  ]
}
