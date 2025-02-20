Provider Configuration:

The azurerm provider is configured to interact with Azure resources. The features {} block is required for the provider to function.

Resource Group:

A resource group (vnet-rg) is created to organize all the resources. The location is set to East US.

Virtual Network (VNet):

A Virtual Network (example-vnet) is created with an IP address range of 10.0.0.0/16. The VNet is associated with the resource group and location.

Subnet:

A subnet (example-subnet) is created within the VNet with an IP address range of 10.0.1.0/24. The subnet is associated with the VNet and resource group.

Outputs:

The VNet ID and Subnet ID are outputted for reference. These IDs can be used in other Terraform configurations or scripts.
