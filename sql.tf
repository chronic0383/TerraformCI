resource "azurerm_mssql_server" "example" {
  name                         = "jclabsmysqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_mssql_firewall_rule" "IP1" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.example.id
  start_ip_address = "10.0.17.62"
  end_ip_address   = "10.0.17.89"
}

resource "azurerm_mssql_firewall_rule" "IP2" {
  name             = "FirewallRule2"
  server_id        = azurerm_mssql_server.example.id
  start_ip_address = "10.0.18.62"
  end_ip_address   = "10.0.18.62"
}
