output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

output "location" {
  value = azurerm_virtual_network.virtual_network.location
}

output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "public_subnet_id" {
  value = azurerm_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.security_group.id
}

output "network_interface_id" {
  value = azurerm_network_interface.network_interface.id
}

output "public_ip" {
  description = "The public IP of the virtual machine."
  value       = azurerm_public_ip.public_ip.id
}
