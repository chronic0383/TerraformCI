terraform {
  required_version = "~>1.14.0"
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
}

provider "azapi" {
}
