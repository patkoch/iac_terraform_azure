resource "azurerm_resource_group" "my-rg" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_container_registry" "my-acr" {
  name                = "my-registry"
  sku                 = "Premium"
  resource_group_name = azurerm_resource_group.my-rg.name
  location            = azurerm_resource_group.my-rg.location
}

resource "azurerm_kubernetes_cluster" "my-k8s-cluster" {
  name                = var.kubernetes_cluster_name
  location            = azurerm_resource_group.my-rg.location
  resource_group_name = azurerm_resource_group.my-rg.name
  dns_prefix          = "my.domain.prefix"

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
  scope                            = azurerm_container_registry.my-acr.id
  skip_service_principal_aad_check = true
}

