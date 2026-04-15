# Create a new resource group for AI Foundry
resource "azurerm_resource_group" "ai_foundry_rg" {
  name     = "jclabsaitest"
  location = "uksouth"
}

# Data source to reference existing Key Vault
data "azurerm_key_vault" "existing" {
  name                = "jclabstestkeyv"
  resource_group_name = "rg-jclabs-prod"
}

# Data source to reference existing Application Insights
data "azurerm_application_insights" "existing" {
  name                = "tf-test-appinsights"
  resource_group_name = "tf-test"
}

# Create AI Foundry resource
resource "azurerm_ai_studio" "main" {
  name                = "jclabsaifoundry"
  location            = azurerm_resource_group.ai_foundry_rg.location
  resource_group_name = azurerm_resource_group.ai_foundry_rg.name
  friendly_name       = "jclabsaifoundry"

  # Reference existing Key Vault
  key_vault_id = data.azurerm_key_vault.existing.id

  # Reference existing Application Insights
  application_insights_id = data.azurerm_application_insights.existing.id

  # Enable system-assigned managed identity
  identity {
    type = "SystemAssigned"
  }
}

# Create AI Foundry Project
resource "azurerm_ai_studio_project" "main" {
  name                = "jclabs-test"
  resource_group_name = azurerm_resource_group.ai_foundry_rg.name
  location            = azurerm_resource_group.ai_foundry_rg.location
  ai_studio_id        = azurerm_ai_studio.main.id
  friendly_name       = "jclabs-test"
  display_name        = "jclabs-test"
  description         = "AI Foundry Test Project"
}

