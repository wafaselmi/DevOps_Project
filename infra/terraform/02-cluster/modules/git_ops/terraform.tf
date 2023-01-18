terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.7.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}