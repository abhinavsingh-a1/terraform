# Configure the Azure provider
provider "azurerm" {
  features {}  # Required for the Azure provider
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "function-rg"  # Name of the resource group
  location = "East US"  # Azure region for the resources
}

# Create a Storage Account for the Function App
resource "azurerm_storage_account" "storage" {
  name                     = "funcstorageaccount"  # Name of the storage account (must be unique globally)
  resource_group_name      = azurerm_resource_group.rg.name  # Use the resource group name
  location                 = azurerm_resource_group.rg.location  # Use the location from the resource group
  account_tier             = "Standard"  # Storage account tier (Standard or Premium)
  account_replication_type = "LRS"  # Locally redundant storage (LRS)
}

# Create an App Service Plan for the Function App
resource "azurerm_app_service_plan" "asp" {
  name                = "function-app-service-plan"  # Name of the App Service Plan
  location            = azurerm_resource_group.rg.location  # Use the location from the resource group
  resource_group_name = azurerm_resource_group.rg.name  # Use the resource group name
  kind                = "FunctionApp"  # Specify that this is for a Function App
  sku {
    tier = "Dynamic"  # Consumption plan tier (Dynamic for serverless)
    size = "Y1"  # Size of the plan (Y1 for consumption plan)
  }
}

# Create the Function App
resource "azurerm_function_app" "function" {
  name                       = "example-function-app"  # Name of the Function App (must be unique globally)
  location                   = azurerm_resource_group.rg.location  # Use the location from the resource group
  resource_group_name        = azurerm_resource_group.rg.name  # Use the resource group name
  app_service_plan_id        = azurerm_app_service_plan.asp.id  # Associate with the App Service Plan
  storage_account_name       = azurerm_storage_account.storage.name  # Associate with the Storage Account
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key  # Storage account access key
  os_type                    = "linux"  # OS type for the Function App (linux or windows)
  version                    = "~4"  # Runtime version for the Function App (e.g., ~4 for the latest version of Functions runtime)

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"  # Specify the runtime (e.g., node for Node.js, python for Python, etc.)
  }

  site_config {
    linux_fx_version = "NODE|16-lts"  # Specify the runtime stack (e.g., Node.js 16 LTS)
  }
}

# Output the Function App URL
output "function_app_url" {
  value = azurerm_function_app.function.default_hostname  # Output the Function App URL
}
