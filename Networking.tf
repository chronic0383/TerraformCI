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

