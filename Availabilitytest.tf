resource "azurerm_resource_group" "example" {
  name     = "tf-test"
  location = "UK South"
}

resource "azurerm_application_insights" "example" {
  name                = "tf-test-appinsights"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"
}

output "instrumentation_key" {
  value     = azurerm_application_insights.example.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.example.app_id
}
