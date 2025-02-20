# Configure the Azure provider
provider "azurerm" {
  features {}  # Required for the Azure provider
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "vnet-rg"  # Name of the resource group
  location = "East US"  # Azure region for the resources
}

# Create a Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = "example-vnet"  # Name of the Virtual Network
  address_space       = ["10.0.0.0/16"]  # IP address range for the VNet
  location            = azurerm_resource_group.rg.location  # Use the location from the resource group
  resource_group_name = azurerm_resource_group.rg.name  # Use the resource group name
}

# Create a Subnet within the Virtual Network
resource "azurerm_subnet" "subnet" {
  name                 = "example-subnet"  # Name of the subnet
  resource_group_name  = azurerm_resource_group.rg.name  # Use the resource group name
  virtual_network_name = azurerm_virtual_network.vnet.name  # Use the VNet name
  address_prefixes     = ["10.0.1.0/24"]  # IP address range for the subnet
}

# Output the VNet ID and Subnet ID
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id  # Output the VNet ID
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id  # Output the Subnet ID
}
