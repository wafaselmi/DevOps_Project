resource "azurerm_resource_group" "deployment" {
  name     = "deployment-automation"
  location = "France Central"

  tags = {
    environment = "Development"
  }
}

resource "azurerm_kubernetes_cluster" "videomp3-cluster" {
  name                = "videomp3-converter"
  location            = azurerm_resource_group.deployment.location
  resource_group_name = azurerm_resource_group.deployment.name
  dns_prefix          = "videomp3-converter"
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
