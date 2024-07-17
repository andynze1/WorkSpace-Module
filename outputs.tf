output "resource_group_name" {
  value = module.network.resource_group_name
}

output "location" {
  value = module.network.location
}

output "build_server_ip" {
  value = module.vm.build_server_ip
}

# output "virtual_network_name" {
#   value = module.network.virtual_network_name
# }

# output "public_subnet_id" {
#   value = module.network.public_subnet_id
# }

# output "private_subnet_id" {
#   value = module.network.private_subnet_id
# }

# output "network_interface_id" {
#   value = module.network.network_interface_id
# }

# output "public_ip" {
#   value = module.network.public_ip
# }

# output "vm_id" {
#   value = module.vm.vm_id
# }


