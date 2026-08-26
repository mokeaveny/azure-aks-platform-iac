resource "azurerm_resource_group" "resource_group" {
  name     = "${var.project_name}-resources"
  location = var.location
}

module "networking" {
  source              = "./modules/networking"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

module "acr" {
  source              = "./modules/acr"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

module "aks" {
  source              = "./modules/aks"
  project_name        = var.project_name
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  environment         = var.environment
  subnet_id           = module.networking.subnet_id
  acr_id              = module.acr.acr_id
}