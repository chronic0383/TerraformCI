# Create a new resource group for AI Foundry
resource "azurerm_resource_group" "ai_foundry_rg" {
  name     = "jclabsaitest"
  location = "uksouth"
}

# Create AI Foundry resource
resource "azapi_resource" "foundry" {
  type      = "Microsoft.CognitiveServices/accounts@2025-12-01"
  name      = "jclabsaifoundry"
  location  = azurerm_resource_group.ai_foundry_rg.location
  parent_id = azurerm_resource_group.ai_foundry_rg.id

  schema_validation_enabled = false

  body = {
    kind = "AIServices"
    sku = {
      name = "S0"
    }
    properties = {
      allowProjectManagement = true
      publicNetworkAccess    = "Enabled"
    }
  }

  identity {
    type = "SystemAssigned"
  }
}

# Create AI Foundry Project
resource "azapi_resource" "project" {
  type      = "Microsoft.CognitiveServices/accounts/projects@2025-12-01"
  name      = "jclabs-test"
  parent_id = azapi_resource.foundry.id
  location  = azurerm_resource_group.ai_foundry_rg.location

  schema_validation_enabled = false

  body = {
    properties = {
      allowProjectManagement = true
    }
  }

  identity {
    type = "SystemAssigned"
  }
}
#
