resource "azurerm_container_registry" "acr" {
  # Name must be alphanumeric only so we're replacing the hyphens with nothing
  name                = replace("${var.project_name}acr", "-", "")
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}