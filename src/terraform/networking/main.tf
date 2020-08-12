# Creates virtual network
resource "azurerm_virtual_network" "main" {
  name = "vnet-jenkins"
  resource_group_name = var.rgn
  location = var.location
  address_space = var.network_address
}

# Creates subnet in the virtual network
resource "azurerm_subnet" "main" {
  name = "sn-jenkins"
  resource_group_name = var.rgn
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes = var.subnet_address
}

# Create a public ip address to be used by the jenkins instance
resource "azurerm_public_ip" "main" {
  name = "pip-jenkins"
  resource_group_name = var.rgn
  location = var.location
  allocation_method = "Dynamic"
  sku = "Basic"
}

# Create the network interace for the jenkins instance
resource "azurerm_network_interface" "main" {
  name = "nic-jenkins"
  resource_group_name = var.rgn
  location = var.location
  
  ip_configuration{
    name = "ipconfig1"
    subnet_id = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

# SECURITY
# Creates security group for rules to be applied to jenkins
resource "azurerm_network_security_group" "main" {
  name = "sg-jenkins"
  resource_group_name = var.rgn
  location = var.location
}

# Allow SSH access
resource "azurerm_network_security_rule" "ssh_access" {
  name = "ssh-access-rule"
  resource_group_name = var.rgn
  network_security_group_name = azurerm_network_security_group.main.name
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  destination_port_range = "22"
  protocol = "TCP"
  priority = 200
  source_address_prefix = var.allowed_ips
  destination_address_prefix = sort(var.network_address)[0] 
}

# Allow access to the jenkins instance
resource "azurerm_network_security_rule" "jenkins_access" {
  name = "jenkins-access-rule"
  resource_group_name = var.rgn
  network_security_group_name = azurerm_network_security_group.main.name
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  destination_port_range = "8090"
  protocol = "TCP"
  priority = 205
  source_address_prefix = var.allowed_ips
  destination_address_prefix = sort(var.network_address)[0] 
}
