provider "azurerm" {
  features {}
  subscription_id = "bbe07c0a-0501-42b0-8952-c2138902a60b"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.azure_region
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "microservices-demo-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "microservices-demo"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}



#comment 
#comment
#commet
