variable "resource_group" {
  description = "The name of the resource group"
  type        = string
  default     = "resource_group"
}

variable "location" {
  description = "The Azure location where resources will be created"
  type        = string
  default     = "East US"
}

variable "virtual_network" {
  description = "The name of the virtual network"
  type = object({
    name          = string
    address_space = list(string)
  })
  default = {
    name          = "virtual-network"
    address_space = []
  }
}

# variable "virtual_network_address_space" {
#   description = "The address space for the virtual network"
#   type        = list(string)
# }

variable "public_subnet_name" {
  description = "The name of the public subnet"
  type        = string
  default     = "public_subnet"
}

variable "private_subnet_name" {
  description = "The name of the private subnet"
  type        = string
  default     = "private_subnet"
}

variable "my_ip_address" {
  description = "Your IP address with a /32 subnet mask"
  type        = string
  default     = "146.85.136.101/32"
}
