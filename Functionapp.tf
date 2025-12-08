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

  site_config {}
}
# Add IP-based access restrictions
resource "azurerm_function_app_function_app_http_allowed_ip_restriction" "example" {
  function_app_id = azurerm_windows_function_app.example.id

  # Allow specific IPs only
  ip_address = "86.162.82.32/32" # Your allowed IP
  priority   = 100
  action     = "Allow"
  name       = "AllowSpecificIP"
}

# Deny all other public access
resource "azurerm_function_app_function_app_http_allowed_ip_restriction" "deny_all" {
  function_app_id = azurerm_windows_function_app.example.id

  ip_address = "*"
  priority   = 200
  action     = "Deny"
  name       = "DenyAllOthers"
}
