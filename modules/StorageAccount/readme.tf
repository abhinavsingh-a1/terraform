Provider Block :
The provider "azurerm" block specifies that we are using the AzureRM provider to manage Azure resources.
The version attribute ensures compatibility by specifying the version of the provider.
The features {} block is required for some newer features in the AzureRM provider.

Resource Group :
The azurerm_resource_group resource defines a resource group in Azure.
The name attribute specifies the name of the resource group.
The location attribute specifies the region where the resource group will be created.

Storage Account :
The azurerm_storage_account resource creates an Azure Storage Account.
The name attribute must be globally unique and follow Azure naming conventions (lowercase letters and numbers only).
The resource_group_name links the storage account to the previously defined resource group.
The location matches the location of the resource group.
The account_tier specifies the performance tier (Standard or Premium).
The account_replication_type defines the type of replication (LRS, GRS, etc.).
The enable_https_traffic_only ensures that only secure HTTPS traffic is allowed.
The tags attribute adds metadata to the resource for organizational purposes.

Outputs :
The output blocks provide useful information about the created resources, such as the storage account name and its connection string.
These outputs can be used in other scripts or for reference after the Terraform apply process.
