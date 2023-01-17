data "azurerm_resource_group" "dev" {
  name = var.resource_group_name
}
resource "azurerm_kubernetes_cluster" "dad-cluster" {
  name                = "dad-cluster"
  location            = data.azurerm_resource_group.dev.location
  resource_group_name = data.azurerm_resource_group.dev.name
  dns_prefix          = "dad-cluster"
  sku_tier            = "Free"
  http_application_routing_enabled = true

  default_node_pool {
    name                = "default"
    enable_auto_scaling = true
    min_count           = 2
    max_count           = 3
    vm_size             = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"
    network_policy = "calico"
  }

  provisioner "local-exec" {
    command = "echo ${self.kube_config_raw} >> ~/.kube/config"
  }

  tags = {
    Environment = "Development"
  }
}
locals {
  host                   = azurerm_kubernetes_cluster.dad-cluster.kube_config.0.host
  username               = azurerm_kubernetes_cluster.dad-cluster.kube_config.0.username
  password               = azurerm_kubernetes_cluster.dad-cluster.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.dad-cluster.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.dad-cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.dad-cluster.kube_config.0.cluster_ca_certificate)
}

provider "kubernetes" {
  alias                  = "my-cluster"
  host                   = local.host
  username               = local.username
  password               = local.password
  client_certificate     = local.client_certificate
  client_key             = local.client_key
  cluster_ca_certificate = local.cluster_ca_certificate
}


provider "helm" {
  kubernetes {
    host                   = local.host
    username               = local.username
    password               = local.password
    client_certificate     = local.client_certificate
    client_key             = local.client_key
    cluster_ca_certificate = local.cluster_ca_certificate
  }
}


module "setup_gitops" {
  source = "./modules/git_ops"
  providers = {
    helm = helm
  }
  namespace = default
  }