# Create a new resource group for AI Foundry
resource "azurerm_resource_group" "ai_foundry_rg" {
  name     = "jclabsaitest"
  location = "uksouth"
}

# Data source to reference existing Key Vault
data "azurerm_key_vault" "existing" {
  id = "/subscriptions/514baea0-027d-4c91-a0b1-f5f162343306/resourceGroups/rg-jclabs-prod/providers/Microsoft.KeyVault/vaults/jclabstestkeyv"
}

# Data source to reference existing Application Insights
data "azurerm_application_insights" "existing" {
  id = "/subscriptions/514baea0-027d-4c91-a0b1-f5f162343306/resourceGroups/tf-test/providers/microsoft.insights/components/tf-test-appinsights"
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
}
