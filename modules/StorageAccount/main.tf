# Define the required provider for Azure
provider "azurerm" {
  # Specify the version of the AzureRM provider
  version = "~> 3.0"

  # Set the features block to enable specific features in the provider
  features {}
}

# Define a resource group for the storage account
resource "azurerm_resource_group" "example" {
  # Name of the resource group
  name     = "example-resource-group"

  # Location where the resource group will be created (e.g., East US)
  location = "eastus"
}

# Define the Azure Storage Account resource
resource "azurerm_storage_account" "example" {
  # Name of the storage account (must be unique across Azure)
  name                     = "examplestorageacct123"

  # Link the storage account to the resource group defined above
  resource_group_name      = azurerm_resource_group.example.name

  # Location of the storage account (same as the resource group)
  location                 = azurerm_resource_group.example.location

  # Tier of the storage account (Standard or Premium)
  account_tier             = "Standard"

  # Type of replication for the storage account
  account_replication_type = "LRS" # LRS: Locally-redundant storage

  # Enable HTTPS traffic only (recommended for security)
  enable_https_traffic_only = true

  # Tags for organizing resources
  tags = {
    environment = "dev"
    cost_center = "12345"
  }
}

# Output the storage account name for reference
output "storage_account_name" {
  value = azurerm_storage_account.example.name
  description = "The name of the Azure Storage Account created."
}

# Output the primary connection string for the storage account
output "storage_account_connection_string" {
  value = azurerm_storage_account.example.primary_connection_string
  description = "The primary connection string for the Azure Storage Account."
}
