output "acr_id" {
    value = azurerm_container_registry.acr.id
}

# The URL that can be used to log into the container registry
output "acr_login_server" {
    value = azurerm_container_registry.acr.login_server
}