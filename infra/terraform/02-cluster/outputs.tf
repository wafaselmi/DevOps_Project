output "kube_config" {
  value     = azurerm_kubernetes_cluster.dad-cluster.kube_config
  sensitive = true
}

output "DNS_Zone_Name" {
  value = azurerm_kubernetes_cluster.dad-cluster.http_application_routing_zone_name
  sensitive = false
}