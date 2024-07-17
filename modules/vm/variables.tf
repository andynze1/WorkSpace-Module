variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be created"
  type        = string
}

variable "network_interface_id" {
  description = "ID of the network interface"
  type        = string
}

variable "build_server" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

# variable "admin_username" {
#   description = "The admin username for the virtual machine"
#   type        = string
# }

# variable "public_key_path" {
#   description = "The path to the SSH public key"
#   type        = string
# }

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}
