# Define the required provider for Azure
provider "azurerm" {
  # Specify the version of the AzureRM provider
  version = "~> 3.0"

  # Set the features block to enable specific features in the provider
  features {}
}

# Define a resource group for the App Service Plan and Web App
resource "azurerm_resource_group" "example" {
  # Name of the resource group
  name     = "example-appservice-resource-group"

  # Location where the resource group will be created (e.g., East US)
  location = "eastus"
}

# Define an Azure App Service Plan
resource "azurerm_app_service_plan" "example" {
  # Name of the App Service Plan
  name                = "example-appservice-plan"

  # Link the App Service Plan to the resource group defined above
  resource_group_name = azurerm_resource_group.example.name

  # Location of the App Service Plan (same as the resource group)
  location            = azurerm_resource_group.example.location

  # Pricing tier for the App Service Plan
  sku {
    # Tier of the App Service Plan (options: Free, Shared, Basic, Standard, Premium, etc.)
    tier = "Standard"

    # Size of the App Service Plan (e.g., S1, S2, S3 for Standard tier)
    size = "S1"
  }
}

# Define an Azure Web App
resource "azurerm_app_service" "example" {
  # Name of the Web App (must be unique across Azure)
  name                = "example-webapp"

  # Link the Web App to the resource group defined above
  resource_group_name = azurerm_resource_group.example.name

  # Location of the Web App (same as the resource group)
  location            = azurerm_resource_group.example.location

  # Link the Web App to the App Service Plan defined above
  app_service_plan_id = azurerm_app_service_plan.example.id

  # Site configuration for the Web App
  site_config {
    # Application settings for the Web App
    application_stack {
      # Specify the runtime stack (e.g., .NET, Node.js, Python, etc.)
      dotnet_version = "v6.0" # Example: Use .NET 6.0 runtime
    }

    # Other configuration options (optional)
    always_on = true # Keep the app running even when there is no traffic
  }

  # App settings for the Web App (key-value pairs)
  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14" # Example: Set Node.js version
    "APPINSIGHTS_INSTRUMENTATIONKEY" = "your-instrumentation-key" # Optional: Add App Insights key
  }

  # Tags for organizing resources
  tags = {
    environment = "dev"
    cost_center = "12345"
  }
}

# Output the URL of the Web App
output "web_app_url" {
  value       = azurerm_app_service.example.default_site_hostname
  description = "The default hostname of the Azure Web App."
}

# Output the App Service Plan ID
output "app_service_plan_id" {
  value       = azurerm_app_service_plan.example.id
  description = "The ID of the Azure App Service Plan."
}
