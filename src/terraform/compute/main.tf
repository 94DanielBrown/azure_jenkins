resource "azurerm_virtual_machine" "main" {
  name = "vm-jenkins"
  location = var.location
  resource_group_name = var.rgn
  network_interface_ids = [var.nic_id]
  vm_size = var.vm_size

  storage_image_reference {
  publisher = var.image_publisher
  offer = var.image_offer
  sku = var.image_sku
  version = var.image_version
  }

  storage_os_disk {
    name = "myosdisk1"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "vm-jenkins" 
    admin_username = var.admin_username
    #    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = true 
    
    ssh_keys {
    path = "/home/${var.admin_username}/.ssh/authorized_keys"
    key_data = file("~/.az/pem/personal-northeurope.pub")
    }

  }


  tags = var.default_tags


}



