# Source: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet
resource "random_pet" "pet_name_generator" {
  length = 1
}

# Source: https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer
resource "random_integer" "integer_generator" {
  min = 1
  max = 100
}

# Source: https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=terraform
resource "azurerm_resource_group" "devopsexp_storage_rg" {
  name     = "devopsexperiences-storage"
  location = "westeurope"
}

resource "azurerm_storage_account" "devopsexp_storage_account_tfstate" {
  name                     = "${random_pet.pet_name_generator.id}${random_integer.integer_generator.id}"
  resource_group_name      = azurerm_resource_group.devopsexp_storage_rg.name
  location                 = azurerm_resource_group.devopsexp_storage_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = false
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "terraformstate"
  storage_account_name  = azurerm_storage_account.devopsexp_storage_account_tfstate.name
  container_access_type = "private"
}