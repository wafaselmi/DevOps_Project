terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "dad"
    container_name       = "dad-storcontainer"
    storage_account_name = "terraformstateconv"
    key                  = "dad.json"
  }
}