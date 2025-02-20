# Configure the Azure provider
provider "azurerm" {
  features {}  # Required for the Azure provider
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "vm-rg"  # Name of the resource group
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

# Create a Public IP for the VM
resource "azurerm_public_ip" "public_ip" {
  name                = "vm-public-ip"  # Name of the public IP
  location            = azurerm_resource_group.rg.location  # Use the location from the resource group
  resource_group_name = azurerm_resource_group.rg.name  # Use the resource group name
  allocation_method   = "Static"  # Static or Dynamic IP allocation
  sku                 = "Basic"  # SKU for the public IP
}

# Create a Network Interface (NIC) for the VM
resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"  # Name of the network interface
  location            = azurerm_resource_group.rg.location  # Use the location from the resource group
  resource_group_name = azurerm_resource_group.rg.name  # Use the resource group name

  ip_configuration {
    name                          = "internal"  # Name of the IP configuration
    subnet_id                     = azurerm_subnet.subnet.id  # Associate with the subnet
    private_ip_address_allocation = "Dynamic"  # Dynamic or Static private IP allocation
    public_ip_address_id          = azurerm_public_ip.public_ip.id  # Associate with the public IP
  }
}

# Create a Virtual Machine (VM)
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "example-vm"  # Name of the VM
  resource_group_name = azurerm_resource_group.rg.name  # Use the resource group name
  location            = azurerm_resource_group.rg.location  # Use the location from the resource group
  size                = "Standard_B1s"  # VM size (e.g., Standard_B1s for a small VM)
  admin_username      = "adminuser"  # Admin username for the VM
  network_interface_ids = [azurerm_network_interface.nic.id]  # Associate with the NIC

  admin_ssh_key {
    username   = "adminuser"  # SSH username
    public_key = file("~/.ssh/id_rsa.pub")  # Path to your SSH public key
  }

  os_disk {
    caching              = "ReadWrite"  # Disk caching option
    storage_account_type = "Standard_LRS"  # Disk storage type
  }

  source_image_reference {
    publisher = "Canonical"  # Image publisher (e.g., Canonical for Ubuntu)
    offer     = "UbuntuServer"  # Image offer (e.g., UbuntuServer)
    sku       = "18.04-LTS"  # Image SKU (e.g., 18.04-LTS for Ubuntu 18.04 LTS)
    version   = "latest"  # Image version
  }
}

# Output the Public IP of the VM
output "vm_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address  # Output the public IP address
}
