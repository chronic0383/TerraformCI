# Create a new resource group for AI Foundry
resource "azurerm_resource_group" "ai_foundry_rg" {
  name     = "jclabsaitest"
  location = "uksouth"
}

# Create AI Foundry resource
resource "azapi_resource" "foundry" {
  type      = "Microsoft.CognitiveServices/accounts@2023-05-01"
  name      = "jclabsaifoundry"
  location  = azurerm_resource_group.ai_foundry_rg.location
  parent_id = azurerm_resource_group.ai_foundry_rg.id

  body = jsonencode({
    kind = "AIServices"
    sku = {
      name = "S0"
    }
    properties = {
      allowProjectManagement = true
      publicNetworkAccess    = "Enabled"
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

# Create AI Foundry Project
resource "azurerm_cognitive_account_project" "main" {
  name                 = "jclabs-test"
  cognitive_account_id = azapi_resource.foundry.id
  location             = azurerm_resource_group.ai_foundry_rg.location

  identity {
    type = "SystemAssigned"
  }
}
