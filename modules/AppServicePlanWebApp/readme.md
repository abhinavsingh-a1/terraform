Provider Block :
The provider "azurerm" block specifies that we are using the AzureRM provider to manage Azure resources.
The version attribute ensures compatibility by specifying the version of the provider.
The features {} block is required for some newer features in the AzureRM provider.

Resource Group :
The azurerm_resource_group resource defines a resource group in Azure.
The name attribute specifies the name of the resource group.
The location attribute specifies the region where the resource group will be created.

App Service Plan :
The azurerm_app_service_plan resource creates an Azure App Service Plan.
The name attribute specifies the name of the App Service Plan.
The resource_group_name links the App Service Plan to the previously defined resource group.
The location matches the location of the resource group.
The sku block defines the pricing tier for the App Service Plan:
tier: Specifies the tier (e.g., Free, Shared, Basic, Standard, Premium).
size: Specifies the size within the tier (e.g., S1, S2, S3 for Standard tier).

Web App :
The azurerm_app_service resource creates an Azure Web App.
The name attribute specifies the name of the Web App, which must be unique across Azure.
The resource_group_name links the Web App to the previously defined resource group.
The location matches the location of the resource group.
The app_service_plan_id links the Web App to the previously defined App Service Plan.
The site_config block configures the runtime and other settings for the Web App:
application_stack: Specifies the runtime stack (e.g., .NET, Node.js, Python).
always_on: Ensures the app remains active even when there is no traffic (useful for production apps).
The app_settings block defines key-value pairs for application settings (e.g., environment variables).

Outputs :
The output blocks provide useful information about the created resources:
web_app_url: The default hostname of the Azure Web App, which can be used to access the app.
app_service_plan_id: The ID of the Azure App Service Plan, which can be referenced in other scripts or configurations.
