terraform {
  required_version = ">= 1.14.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "azure-aks-platform-iac-management-resources"
    storage_account_name = "tfstate66170"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}