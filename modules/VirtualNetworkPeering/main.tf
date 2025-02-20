# Define the required provider for Azure
provider "azurerm" {
  # Specify the version of the AzureRM provider
  version = "~> 3.0"

  # Set the features block to enable specific features in the provider
  features {}
}

# Define a resource group for the virtual networks
resource "azurerm_resource_group" "example" {
  # Name of the resource group
  name     = "example-vnet-resource-group"

  # Location where the resource group will be created (e.g., East US)
  location = "eastus"
}

# Define the first Azure Virtual Network
resource "azurerm_virtual_network" "vnet1" {
  # Name of the first virtual network
  name                = "vnet1"

  # Link the virtual network to the resource group defined above
  resource_group_name = azurerm_resource_group.example.name

  # Location of the virtual network (same as the resource group)
  location            = azurerm_resource_group.example.location

  # Address space for the virtual network
  address_space       = ["10.0.0.0/16"]

  # Tags for organizing resources
  tags = {
    environment = "dev"
    cost_center = "12345"
  }
}

# Define the second Azure Virtual Network
resource "azurerm_virtual_network" "vnet2" {
  # Name of the second virtual network
  name                = "vnet2"

  # Link the virtual network to the resource group defined above
  resource_group_name = azurerm_resource_group.example.name

  # Location of the virtual network (same as the resource group)
  location            = azurerm_resource_group.example.location

  # Address space for the virtual network
  address_space       = ["10.1.0.0/16"]

  # Tags for organizing resources
  tags = {
    environment = "dev"
    cost_center = "12345"
  }
}

# Define the Virtual Network Peering from vnet1 to vnet2
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  # Name of the peering connection
  name                      = "vnet1-to-vnet2"

  # Link the peering to the first virtual network
  resource_group_name       = azurerm_resource_group.example.name
  virtual_network_name      = azurerm_virtual_network.vnet1.name

  # Specify the remote virtual network to peer with
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id

  # Allow forwarded traffic between the virtual networks
  allow_forwarded_traffic   = true

  # Allow gateway transit through the local virtual network
  allow_gateway_transit     = false

  # Use remote gateways for the local virtual network
  use_remote_gateways       = false

  # Allow virtual network access
  allow_virtual_network_access = true
}

# Define the Virtual Network Peering from vnet2 to vnet1
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  # Name of the peering connection
  name                      = "vnet2-to-vnet1"

  # Link the peering to the second virtual network
  resource_group_name       = azurerm_resource_group.example.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name

  # Specify the remote virtual network to peer with
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id

  # Allow forwarded traffic between the virtual networks
  allow_forwarded_traffic   = true

  # Allow gateway transit through the local virtual network
  allow_gateway_transit     = false

  # Use remote gateways for the local virtual network
  use_remote_gateways       = false

  # Allow virtual network access
  allow_virtual_network_access = true
}
