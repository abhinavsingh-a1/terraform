# Define the required provider for Azure
provider "azurerm" {
  # Specify the version of the AzureRM provider
  version = "~> 3.0"

  # Set the features block to enable specific features in the provider
  features {}
}

# Define a resource group for the AKS cluster
resource "azurerm_resource_group" "example" {
  # Name of the resource group
  name     = "example-aks-resource-group"

  # Location where the resource group will be created (e.g., East US)
  location = "eastus"
}

# Define the AKS cluster resource
resource "azurerm_kubernetes_cluster" "example" {
  # Name of the AKS cluster (must be unique within the resource group)
  name                = "example-aks-cluster"

  # Link the AKS cluster to the resource group defined above
  resource_group_name = azurerm_resource_group.example.name

  # Location of the AKS cluster (same as the resource group)
  location            = azurerm_resource_group.example.location

  # DNS prefix for the Kubernetes API server
  dns_prefix          = "exampleaks"

  # Default node pool configuration
  default_node_pool {
    # Name of the default node pool
    name       = "default"

    # Number of nodes in the default node pool
    node_count = 2

    # VM size for the nodes in the default node pool
    vm_size    = "Standard_DS2_v2"
  }

  # Kubernetes version (use the latest stable version or specify a specific version)
  kubernetes_version = "1.26.0" # Replace with the desired version if needed

  # Enable managed identity for the AKS cluster
  identity {
    type = "SystemAssigned"
  }

  # Tags for organizing resources
  tags = {
    environment = "dev"
    cost_center = "12345"
  }
}

# Output the Kubernetes cluster's FQDN for accessing the API server
output "aks_cluster_fqdn" {
  value       = azurerm_kubernetes_cluster.example.fqdn
  description = "The fully qualified domain name (FQDN) of the Kubernetes API server."
}

# Output the kube_config for connecting to the cluster
output "aks_kube_config" {
  value       = azurerm_kubernetes_cluster.example.kube_config_raw
  description = "The kubeconfig file content for connecting to the AKS cluster."
  sensitive   = true # Mark as sensitive to avoid exposing credentials in plain text
}
