# Configure Azure provider
provider "azurerm" {
  version = "=2.20.0"
  features{}
}

# Create a random string, used for creating unique names for resources that require one
resource "random_string" "default" {
  length = 8 
  upper = false
  special = false
}

# Create resource group
resource "azurerm_resource_group" "main" {
  name = "rg-jenkins"
  location = vars.location 

  tags={
    environment="jenkins"
    deployedby="Daniel Brown"
  }
}

# Create storage account
resource "azurerm_storage_account" "main" {
  ame = "st-jenkins-$(random_string.default.result}"



