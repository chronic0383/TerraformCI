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

  backup {
    name                = "daily-backup"
    storage_account_url = azurerm_storage_account.storage1.name

    schedule {
      frequency_interval       = 1
      frequency_unit           = "Day"
      keep_at_least_one_backup = true
      retention_period_in_days = 30
    }
  }
}


