resource "azurerm_sql_server" "example" {
  name                         = "example-sqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "SuperSecretPassword123!"
}

# Multiple firewall rules, one per IP
resource "azurerm_sql_firewall_rule" "ip1" {
  name                = "Allow-IP1"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_sql_server.example.name
  start_ip_address    = "203.0.113.10"
  end_ip_address      = "203.0.113.100"
}

resource "azurerm_sql_firewall_rule" "ip2" {
  name                = "Allow-IP2"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_sql_server.example.name
  start_ip_address    = "198.51.100.25"
  end_ip_address      = "198.51.100.25"
}

