output "vm_id" {
  value = azurerm_linux_virtual_machine.build_server
}

output "build_server_ip" {
  description = "The IP of the Build Server."
  value       = azurerm_linux_virtual_machine.build_server.public_ip_address
}
