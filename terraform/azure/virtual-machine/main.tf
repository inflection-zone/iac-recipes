module "resource-group" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/azure/resource-group"
  # source = "../../../../../../../templates/terraform/modules/azure/resource-group"

  resource-group-properties = local.resource-group-properties
}

module "virtual-network" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/azure/virtual-network"
  # source = "../../../../../../../templates/terraform/modules/azure/virtual-network"

  resource-group-properties  = local.resource-group-properties
  virtual-network-properties = local.virtual-network-properties

  depends_on = [
    module.resource-group
  ]
}

module "virtual-machine" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/azure/virtual-machine"
  # source = "../../../../../../../templates/terraform/modules/azure/virtual-machine"

  resource-group-properties  = local.resource-group-properties
  virtual-machine-properties = local.virtual-machine-properties
  vnet-public-subnet-id      = local.vnet-public-subnet-id

  depends_on = [
    module.virtual-network
  ]
}