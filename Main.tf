
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
}

resource "azurerm_storage_account" "storage1" {
  name                     = "st${var.application_name}${var.environment_name}001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.storage1.name
  container_access_type = "private"

}

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
# End of Main
#
#
