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
resource "azurerm_cognitive_account" "foundry" {
  name                = "jclabsaifoundry"
  location            = azurerm_resource_group.ai_foundry_rg.location
  resource_group_name = azurerm_resource_group.ai_foundry_rg.name

  kind     = "AIServices"
  sku_name = "S0"

  identity {
    type = "SystemAssigned"
  }

  # Attach existing resources
  key_vault_id            = data.azurerm_key_vault.existing.id
  application_insights_id = data.azurerm_application_insights.existing.id
}


# Create AI Foundry Project
resource "azurerm_cognitive_account_project" "main" {
  name                 = "jclabs-test"
  cognitive_account_id = azurerm_cognitive_account.foundry.id
  location             = azurerm_resource_group.ai_foundry_rg.location
}

