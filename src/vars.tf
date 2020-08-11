# General
variable "location" {
  description = "Location to deploy use to deploy jenkins server"
  default = "northeurope"
}

variable "default_tags" {
  description = "Default tags to apply to resources"
  type = "map"
  default = {
    environment: "jenkins",
    deployedby: "Daniel Brown"
  }
}

# Storage
variable "storage_account_tier" {
  description = "The account tier of the storage account"
  default = "Standard"
}

variable "storage_account_replication" {
  description = "The replication type to use with the storage account"
  default = "LRS"
}

# Networking
variable  "network_address" {
  description = "Ip address range for the virtual network"
  default = ["10.15.0.0/16"]
}

variable "subnet_address" {
  description = "Ip address range for the subnet"
  default = ["10.15.1.0/24"]
}

variable "allowed_ips" {
  description = "Set the ip range which will be allowed to access the jenkins instance"
  default = ["0.0.0.0/0"]
}

# Compute 
variable "image_publisher" {
  description = "The publisher oh the OS image used to host jenkins "
  default = "OpenLogic"
}

variable "image_offer" {
  description = "The OS used to host jenkins "
  default = "CentOS"
}

variable "image_version" {
  description = "The version of the OS used to host jenkins"
  default = "latest"
}




