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
