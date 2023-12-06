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

  # Delete the backend block if you want to store the state locally
  backend "azurerm" {
    resource_group_name  = "devopsexperiences-storage"
    storage_account_name = "devopsexp2024"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}
