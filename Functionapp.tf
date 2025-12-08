resource "azurerm_storage_account" "example" {
  name                     = "functionsappjclab1"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = "jclabs-app-service-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "example" {
  name                = "jclabs1-windows-function-app"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  site_config {
    ip_restriction {
      ip_address = "86.162.82.32"
      priority   = 100
      name       = "ETEL FW IP ONLY"
    }
    ip_restriction {
      ip_address = "0.0.0.0/0"
      priority   = 200
      name       = "Block all"
    }
  }
}

