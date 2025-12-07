resource "azurerm_key_vault" "example" {
  name                        = "jclabstestkeyv"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"

    # Allow specific IP ranges
    ip_rules = [
      "203.0.113.10",
      "198.51.100.0/24",
    "198.51.100.26"]
  }
}

