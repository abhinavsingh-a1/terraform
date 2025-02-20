Provider Block :
The provider "azurerm" block specifies that we are using the AzureRM provider to manage Azure resources.
The version attribute ensures compatibility by specifying the version of the provider.
The features {} block is required for some newer features in the AzureRM provider.

Resource Group :
The azurerm_resource_group resource defines a resource group in Azure.
The name attribute specifies the name of the resource group.
The location attribute specifies the region where the resource group will be created.

Key Vault :
The azurerm_key_vault resource creates an Azure Key Vault.
The name attribute specifies the name of the Key Vault, which must be unique across Azure.
The resource_group_name links the Key Vault to the previously defined resource group.
The location matches the location of the resource group.
The tenant_id specifies the Azure Active Directory tenant ID, which can be retrieved using the data.azurerm_client_config data source.
The sku_name specifies the pricing tier (standard or premium).
The soft_delete_retention_days and purge_protection_enabled settings enable soft-delete and purge protection for added security.
The network_acls block configures network access rules:
default_action: Specifies the default action for network access (Deny or Allow).
bypass: Allows Azure services to bypass the network rules.
ip_rules: Defines a list of IP addresses that are allowed to access the Key Vault.

Secret :
The azurerm_key_vault_secret resource creates a secret in the Key Vault.
The name attribute specifies the name of the secret.
The key_vault_id links the secret to the previously defined Key Vault.
The value attribute specifies the value of the secret.

Outputs :
The output blocks provide useful information about the created Key Vault and secret:
key_vault_uri: The URI of the Azure Key Vault, which can be used to access secrets programmatically.
secret_value: The value of the secret stored in the Key Vault. This output is marked as sensitive to prevent accidental exposure of the secret.
