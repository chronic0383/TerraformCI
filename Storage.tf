resource "azurerm_storage_account" "storage1" {
  name                     = "st${var.application_name}${var.environment_name}001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "backup" {
  name                  = "app-backups"
  storage_account_name  = azurerm_storage_account.backup.name
  container_access_type = "private"
}
