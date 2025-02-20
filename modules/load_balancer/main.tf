# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "loadbalancer-rg"  # Name of the resource group
  location = "East US"          # Azure region for the resources
}

# Create a Virtual Network (VNet)
resource "azurerm_virtual_network" "vnet" {
  name                = "loadbalancer-vnet"  # Name of the VNet
  address_space       = ["10.0.0.0/16"]     # IP address range for the VNet
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a Subnet within the VNet
resource "azurerm_subnet" "subnet" {
  name                 = "loadbalancer-subnet"  # Name of the subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]       # IP address range for the subnet
}

# Create a Public IP for the Load Balancer
resource "azurerm_public_ip" "public_ip" {
  name                = "loadbalancer-public-ip"  # Name of the public IP
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"                 # Static or Dynamic IP allocation
  sku                 = "Basic"                 # SKU for the public IP
}

# Create the Load Balancer
resource "azurerm_lb" "lb" {
  name                = "loadbalancer-lb"  # Name of the Load Balancer
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Basic"           # SKU for the Load Balancer

  frontend_ip_configuration {
    name                 = "loadbalancer-frontend-ip"  # Name of the frontend IP configuration
    public_ip_address_id = azurerm_public_ip.public_ip.id  # Associate the public IP
  }
}

# Create a Backend Address Pool for the Load Balancer
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.lb.id  # Associate with the Load Balancer
  name            = "loadbalancer-backend-pool"  # Name of the backend pool
}

# Create a Health Probe for the Load Balancer
resource "azurerm_lb_probe" "health_probe" {
  loadbalancer_id = azurerm_lb.lb.id  # Associate with the Load Balancer
  name            = "loadbalancer-health-probe"  # Name of the health probe
  port            = 80  # Port to monitor for health checks
  protocol        = "Http"  # Protocol for health checks (Http, Https, or Tcp)
  request_path    = "/"  # Path for HTTP health checks
}

# Create a Load Balancing Rule
resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.lb.id  # Associate with the Load Balancer
  name                           = "loadbalancer-rule"  # Name of the load balancing rule
  protocol                       = "Tcp"  # Protocol for the rule (Tcp or Udp)
  frontend_port                  = 80  # Port on the Load Balancer to listen on
  backend_port                   = 80  # Port on the backend VMs to forward traffic to
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name  # Frontend IP configuration
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]  # Backend pool
  probe_id                       = azurerm_lb_probe.health_probe.id  # Health probe
}

# Output the Public IP of the Load Balancer
output "load_balancer_public_ip" {
  value = azurerm_public_ip.public_ip.ip_address  # Output the public IP address
}
