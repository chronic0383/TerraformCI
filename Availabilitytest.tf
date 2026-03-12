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

# The instrumentation key is sensitive because it can be used to send telemetry to your Application Insights resource.
output "instrumentation_key" {
  value     = azurerm_application_insights.example.instrumentation_key
  sensitive = true
}

output "app_id" {
  value = azurerm_application_insights.example.app_id
}

resource "azurerm_application_insights_web_test" "ping_test" {
  name                    = "availability-test"
  location                = azurerm_resource_group.example.location
  resource_group_name     = azurerm_resource_group.example.name
  application_insights_id = azurerm_application_insights.example.id

  kind = "ping"

  frequency = 300
  timeout   = 30
  enabled   = true

  geo_locations = [
    "emea-nl-ams-azr",
    "emea-uk-lon-azr"
  ]
  configuration = jsonencode({
    WebTestName            = "availability-test"
    Description            = "Availability test for your application"
    Enabled                = true
    Frequency              = 300
    Timeout                = 30
    Url                    = "https://yourapp.com/health"
    HttpVerb               = "GET"
    ParseDependentRequests = false
    FollowRedirects        = true
    Headers = [
      {
        HeaderName  = "Test1"
        HeaderValue = "my-secret-value"
      }
    ]
    ValidationRules = {
      ExpectedHttpStatusCode   = 200
      SSLCertRemainingLifetime = 30
    }
  })
}

