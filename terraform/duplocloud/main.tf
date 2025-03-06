module "duplocloud-infrastructure" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/duplocloud/duplocloud-infrastructure"
  # source = "../../../../../../../templates/devops-templates/terraform/modules/duplocloud/duplocloud-infrastructure"

  duplocloud-infrastructure-properties = local.duplocloud-infrastructure-properties
}

module "duplocloud-tenant" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/duplocloud/duplocloud-tenant"
  # source = "../../../../../../../templates/devops-templates/terraform/modules/duplocloud/duplocloud-tenant"

  duplocloud-tenant-properties = local.duplocloud-tenant-properties
}

module "duplocloud-ecs" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/duplocloud/duplocloud-ecs"
  # source = "../../../../../../../templates/devops-templates/terraform/modules/duplocloud/duplocloud-ecs"

  duplocloud-ecs-properties = local.duplocloud-ecs-properties
  duplocloud-tenant-id      = local.duplocloud-tenant-id
}

module "duplocloud-lambda-function" {
  source = "github.com/inflection-templates/devops-templates/terraform/modules/duplocloud/duplocloud-lambda-function"
  # source = "../../../../../../../templates/devops-templates/terraform/modules/duplocloud/duplocloud-lambda-function"

  duplocloud-lambda-function-properties = local.duplocloud-lambda-function-properties
  duplocloud-tenant-id                  = local.duplocloud-tenant-id
}
