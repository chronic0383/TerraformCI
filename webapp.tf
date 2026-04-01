resource "azurerm_app_service_plan" "example" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "PremiumV3"
    size = "P0V3"
  }
}

resource "azurerm_app_service" "example" {
  name                = "jclabs-app1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    ip_restriction {
      ip_address = "86.162.82.32/32"
      priority   = 100
      name       = "ETEL FW IP ONLY"
    }
    ip_restriction {
      ip_address = "0.0.0.0/0"
      priority   = 200
      name       = "Block all"
      action     = "Deny"
    }
  }
}
# Custom backup configuration
resource "azurerm_app_service_backup" "example" {
  name                = "backup"
  resource_group_name = azurerm_resource_group.rg.name
  app_service_name    = azurerm_app_service.example.name

  storage_account_url = azurerm_storage_container.backup.id

  schedule {
    frequency_interval    = 1 # Every 1 day
    frequency_unit        = "Day"
    retention_period_days = 7                       # Keep backups for 7 days
    start_time            = "2026-04-01T022:00:00Z" # UTC time
  }

  enabled = true


}

