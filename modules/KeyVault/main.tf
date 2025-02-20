# Define the required provider for Azure
provider "azurerm" {
  # Specify the version of the AzureRM provider
  version = "~> 3.0"

  # Set the features block to enable specific features in the provider
  features {}
}

# Define a resource group for the Key Vault
resource "azurerm_resource_group" "example" {
  # Name of the resource group
  name     = "example-keyvault-resource-group"

  # Location where the resource group will be created (e.g., East US)
  location = "eastus"
}

# Define the Azure Key Vault
resource "azurerm_key_vault" "example" {
  # Name of the Key Vault (must be unique across Azure)
  name                        = "examplekeyvault123" # Use a unique name

  # Link the Key Vault to the resource group defined above
  resource_group_name         = azurerm_resource_group.example.name

  # Location of the Key Vault (same as the resource group)
  location                    = azurerm_resource_group.example.location

  # Tenant ID of the Azure Active Directory tenant
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  # SKU of the Key Vault (options: standard, premium)
  sku_name                    = "standard"

  # Enable soft delete and purge protection for added security
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  # Networking configuration (optional)
  network_acls {
    # Default action for network access (Deny or Allow)
    default_action = "Deny"

    # List of IP addresses that are allowed to access the Key Vault
    bypass         = "AzureServices" # Allow Azure services to bypass the network rules
    ip_rules       = ["192.168.1.1/32"] # Example: Allow access from this IP address
  }

  # Tags for organizing resources
  tags = {
    environment = "dev"
    cost_center = "12345"
  }
}

# Define a secret in the Key Vault
resource "azurerm_key_vault_secret" "example" {
  # Name of the secret
  name         = "example-secret"

  # Link the secret to the Key Vault defined above
  key_vault_id = azurerm_key_vault.example.id

  # Value of the secret
  value        = "mysecretvalue" # Replace with the actual secret value
}

# Output the Key Vault URI for accessing secrets
output "key_vault_uri" {
  value       = azurerm_key_vault.example.vault_uri
  description = "The URI of the Azure Key Vault."
}

# Output the secret value (marked as sensitive)
output "secret_value" {
  value       = azurerm_key_vault_secret.example.value
  description = "The value of the secret stored in the Key Vault."
  sensitive   = true # Mark as sensitive to avoid exposing the secret in plain text
}
