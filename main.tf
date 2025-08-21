terraform {
  required_version = ">= 1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.40.0"
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
}

resource "azurerm_resource_group" "rgterraform" {
  name     = "rgterraform"
  location = "UK South"
}
