# create an output for the name of the virtual machine
output "my_virtual_machine_name" {
  value = azurerm_windows_virtual_machine.myvirtualmachine.name
}

# create an output for the resource group name
output "my_resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# create an output for the resource group location
output "my_resource_group_location" {
  value = azurerm_resource_group.rg.location
}

# create an output for the virtual machine public IP address
output "my_virtual_machine_public_ip" {
  value = azurerm_windows_virtual_machine.myvirtualmachine.public_ip_address
}


