# Create a new resource group for AI Foundry
resource "azurerm_resource_group" "ai_foundry_rg" {
  name     = "jclabsaitest"
  location = "uksouth"
}

# Create AI Foundry resource
resource "azurerm_cognitive_account" "foundry" {
  name                = "jclabsaifoundry"
  location            = azurerm_resource_group.ai_foundry_rg.location
  resource_group_name = azurerm_resource_group.ai_foundry_rg.name

  kind     = "AIServices"
  sku_name = "S0"

  identity {
    type = "SystemAssigned"
  }

  public_network_access_enabled = true
}

# Create AI Foundry Project
resource "azurerm_cognitive_account_project" "main" {
  name                 = "jclabs-test"
  cognitive_account_id = azurerm_cognitive_account.foundry.id
  location             = azurerm_resource_group.ai_foundry_rg.location
  identity {
    type = "systemAssigned"
  }
}
