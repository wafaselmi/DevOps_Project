data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}


resource "azurerm_kubernetes_cluster" "dad-cluster" {
  name                = "dad-cluster"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "dad"
  sku_tier            = "Free"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_ds2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

module "setup_gitops" {
  source = "./modules/git_ops"
  providers = {
    helm = helm
  }
}