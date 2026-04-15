# Create a new resource group for AI Foundry
resource "azurerm_resource_group" "ai_foundry_rg" {
  name     = "jclabsaitest"
  location = "uksouth"
}

# -----------------------------
# Existing Key Vault
# -----------------------------
data "azurerm_key_vault" "existing" {
  name                = "jclabstestkeyv"
  resource_group_name = "rg-jclabs-prod"
}

# -----------------------------
# Existing Application Insights
# -----------------------------
data "azurerm_application_insights" "existing" {
  name                = "tf-test-appinsights"
  resource_group_name = "tf-test"
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
      customSubDomainName    = "jclabsaifoundry"

      # Attach Key Vault
      encryption = {
        keyVaultProperties = {
          keyVaultUri = data.azurerm_key_vault.existing.vault_uri
        }
      }
      # Attach Application Insights
      diagnosticSettings = {
        applicationInsights = {
          instrumentationKey = data.azurerm_application_insights.existing.instrumentation_key
        }
      }
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
