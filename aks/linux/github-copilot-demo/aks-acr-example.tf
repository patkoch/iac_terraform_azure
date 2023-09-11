# add a terraform block with the azurerm provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.46.0"
    }
  }
}

# add an azurerm provider block
provider "azurerm" {
  features {}
}

# add an azurerm resource group named "patricks-rg" in west europe
resource "azurerm_resource_group" "patricks-rg" {
  name = "patricks-rg"
  location = "westeurope"
}

# add an aks cluster named "patricks-aks" with two nodes in the default node pool
resource "azurerm_kubernetes_cluster" "patricks-aks" {
  name = "patricks-aks"
  location = azurerm_resource_group.patricks-rg.location
  resource_group_name = azurerm_resource_group.patricks-rg.name
  dns_prefix = "patricks-aks"

  default_node_pool {
    name = "default"
    node_count = 2
    vm_size = "Standard_DS2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  role_based_access_control {
    enabled = true
  }
}

# add an azure container registry named "patricksacr"
resource "azurerm_container_registry" "patricksacr" {
  name = "patricksacr"
  resource_group_name = azurerm_resource_group.patricks-rg.name
  location = azurerm_resource_group.patricks-rg.location
  sku = "Standard"
  admin_enabled = true
}

# enable the aks to pull images from the acr
resource "azurerm_role_assignment" "patricksacr" {
  scope = azurerm_container_registry.patricksacr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_kubernetes_cluster.patricks-aks.kubelet_identity[0].object_id
}