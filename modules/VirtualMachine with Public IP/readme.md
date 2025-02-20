Provider Configuration:

The azurerm provider is configured to interact with Azure resources. The features {} block is required for the provider to function.

Resource Group:

A resource group (vm-rg) is created to organize all the resources. The location is set to East US.

Virtual Network (VNet):

A Virtual Network (example-vnet) is created with an IP address range of 10.0.0.0/16. The VNet is associated with the resource group and location.

Subnet:

A subnet (example-subnet) is created within the VNet with an IP address range of 10.0.1.0/24. The subnet is associated with the VNet and resource group.

Public IP:

A public IP (vm-public-ip) is created for the VM to allow external access. The IP allocation method is set to Static.

Network Interface (NIC):

A network interface (vm-nic) is created and associated with the subnet and public IP.

Virtual Machine (VM):

A Linux VM (example-vm) is created with the following configurations:

VM size: Standard_B1s (a small VM size).

Admin username: adminuser.

SSH key: Uses the public key located at ~/.ssh/id_rsa.pub.

OS disk: Uses Standard_LRS for storage.

Source image: Ubuntu 18.04 LTS.

Output:

The public IP address of the VM is outputted for easy access.
