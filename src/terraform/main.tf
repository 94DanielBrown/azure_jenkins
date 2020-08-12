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
  location = var.location 

  tags = var.default_tags
}

# Create storage account
resource "azurerm_storage_account" "main" {
  name = "stvmjenkins${random_string.default.result}"
  resource_group_name = azurerm_resource_group.main.name
  location = var.location
  account_tier = var.storage_account_tier
  account_replication_type = var.storage_account_replication

  tags = var.default_tags
}

# Create networking
module "networking" {
  source = "./networking"
  rgn = azurerm_resource_group.main.name
  location = var.location
  network_address = var.network_address
  subnet_address = var.subnet_address
  allowed_ips = var.allowed_ips
}

# Create vm
module "compute" {
  source = "./compute"
  rgn = azurerm_resource_group.main.name
  location = var.location
  network_id = module.networking.network_id_out
  subnet_id = module.networking.subnet_id_out
  nic_id = module.networking.nic_id_out
  image_publisher = var.image_publisher
  image_offer = var.image_offer
  image_version = var.image_version
  image_sku = var.image_sku
  vm_size = var.vm_size
  default_tags = var.default_tags
}



