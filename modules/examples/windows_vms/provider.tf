terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "devopsexperiences-storage"
    storage_account_name = "alien39"
    container_name       = "terraformstate"
    key                  = "windows_vms.tfstate"
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}