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
  skip_provider_registration = true
  subscription_id            = "514baea0-027d-4c91-a0b1-f5f162343306"
}

resource "azurerm_resource_group" "rgterraform" {
  name     = "rgterraform"
  location = "UK South"
}
