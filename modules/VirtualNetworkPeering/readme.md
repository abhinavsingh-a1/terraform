Provider Block :
The provider "azurerm" block specifies that we are using the AzureRM provider to manage Azure resources.
The version attribute ensures compatibility by specifying the version of the provider.
The features {} block is required for some newer features in the AzureRM provider.

Resource Group :
The azurerm_resource_group resource defines a resource group in Azure.
The name attribute specifies the name of the resource group.
The location attribute specifies the region where the resource group will be created.

Virtual Networks :
The azurerm_virtual_network resources define two virtual networks (vnet1 and vnet2).
Each virtual network has its own address_space, which defines the IP range used within the network.
Both virtual networks are linked to the same resource group and located in the same region.

Virtual Network Peering :
The azurerm_virtual_network_peering resources create peering connections between the two virtual networks:
vnet1_to_vnet2: Peering from vnet1 to vnet2.
vnet2_to_vnet1: Peering from vnet2 to vnet1.
The remote_virtual_network_id specifies the ID of the virtual network being peered with.
The allow_forwarded_traffic flag allows traffic to be forwarded between the peered networks.
The allow_gateway_transit and use_remote_gateways flags control gateway routing behavior (set to false by default unless needed).
The allow_virtual_network_access flag ensures that resources in the peered networks can communicate with each other.

Peering Configuration :
Peering is bidirectional, so both vnet1 and vnet2 must have peering configurations pointing to each other.
This ensures that resources in both virtual networks can communicate seamlessly.
