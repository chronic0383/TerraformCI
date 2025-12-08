resource "azurerm_storage_account" "storage1" {
  name                     = "st${var.application_name}${var.environment_name}001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]

    # Restrict to specific public IPs
    ip_rules = [
      "203.0.113.10",
    "198.51.100.0/24"]

  }
}
//resource "azurerm_storage_container" "tfstate" {
// name                  = "tfstate"
//storage_account_name  = azurerm_storage_account.storage1.name
//container_access_type = "private"
//

