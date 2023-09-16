resource "azurerm_resource_group" "github-actions-rg" {
  name     = "github-actions"
  location = "West Europe"
}

resource "azurerm_container_registry" "github-actions-acr" {
  name                = "patkochgithubdemo"
  sku                 = "Premium"
  resource_group_name = azurerm_resource_group.github-actions-rg.name
  location            = azurerm_resource_group.github-actions-rg.location
}

resource "azurerm_kubernetes_cluster" "my-k8s-cluster" {
  name                = var.kubernetes_cluster_name
  location            = azurerm_resource_group.github-actions-rg.location
  resource_group_name = azurerm_resource_group.github-actions-rg.name
  dns_prefix          = "my-dns-prefix"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }
  
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

resource "azurerm_role_assignment" "enablePulling" {
  principal_id                     = azurerm_kubernetes_cluster.my-k8s-cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.github-actions-acr.id
  skip_service_principal_aad_check = true
}

