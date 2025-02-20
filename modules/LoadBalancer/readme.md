Provider Configuration:
The azurerm provider is configured to interact with Azure resources. The features {} block is required for the provider to function.

Resource Group:
A resource group (loadbalancer-rg) is created to organize all the resources. The location is set to East US.

Virtual Network (VNet):
A Virtual Network (loadbalancer-vnet) is created with an IP address range of 10.0.0.0/16. The VNet is associated with the resource group and location.

Subnet:
A subnet (loadbalancer-subnet) is created within the VNet with an IP address range of 10.0.1.0/24. The subnet is associated with the VNet and resource group.

Public IP:
A public IP (loadbalancer-public-ip) is created for the Load Balancer to allow external traffic. The IP allocation method is set to Static.

Load Balancer:
A Load Balancer (loadbalancer-lb) is created with a Standard SKU and associated with the public IP.

Backend Address Pool:
A backend pool (loadbalancer-backend-pool) is created to define the group of backend VMs (not included in this script).

Health Probe:
A health probe (loadbalancer-health-probe) is created to monitor the health of the backend VMs on port 80 using HTTP.

Load Balancing Rule:
A load balancing rule (loadbalancer-rule) is created to forward traffic from the Load Balancer's frontend port 80 to the backend VMs' port 80.

Output:
The public IP address of the Load Balancer is outputted for easy access.
