resource "azurerm_virtual_network" "vnet1" {
  name                = "Vnet1uks"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  subnet {
    name             = "Subnet1"
    address_prefixes = ["10.1.1.0/24"]
  }
}

resource "azurerm_virtual_network_peering" "vnet1-to-vnet2" {
  name                         = "vnet1-to-vnet2"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id    = "/subscriptions/8b5b8b3f-1b64-4e47-a3cf-0bd762fc97db/resourceGroups/TR-Peering-test/providers/Microsoft.Network/virtualNetworks/jclabsvnet2"
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
  allow_virtual_network_access = true
}
resource "azurerm_route_table" "route1" {
  name                = "routeTable1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  route {
    name           = "routeToVnet2"
    address_prefix = "10.2.0.0/16"
    next_hop_type  = "VnetLocal"

  }
}
resource "azurerm_subnet_route_table_association" "Subnet1-RouteTable1" {
  subnet_id      = "/subscriptions/514baea0-027d-4c91-a0b1-f5f162343306/resourceGroups/rg-jclabs-prod/providers/Microsoft.Network/virtualNetworks/Vnet1uks/subnets/Subnet1"
  route_table_id = azurerm_route_table.route1.id

}
