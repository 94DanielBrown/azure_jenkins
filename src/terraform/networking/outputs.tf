output "network_id_out" {
  value = azurerm_virtual_network.main.id
}

output "subnet_id_out" {
  value = azurerm_subnet.main.id
}

output "nic_id_out" {
  value = azurerm_network_interface "main" 
}
