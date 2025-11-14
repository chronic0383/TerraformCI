terraform {
  required_version = "1.13.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.40.0"
    }
  }

  cloud {

    organization = "jclabs-learningTF"

    workspaces {
      name = "remotestate"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "514baea0-027d-4c91-a0b1-f5f162343306"
}

resource "azurerm_resource_group" "rg" {
  name     = "rgterraform"
  location = "UK South"
}

resource "azurerm_storage_account" "Terrastorage" {
  name                     = "terrastorageaccnt2025"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_virtual_network" "jclabsvnet1" {
  name                = "jclabsvnet1"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_virtual_network_peering" "jclabsvnet1-to-vnet2" {
  name                      = "jclabsvnet1-to-vnet2"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.jclabsvnet1.name
  remote_virtual_network_id = "/subscriptions/8b5b8b3f-1b64-4e47-a3cf-0bd762fc97db/resourceGroups/TR-Peering-test/providers/Microsoft.Network/virtualNetworks/jclabsvnet2
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}