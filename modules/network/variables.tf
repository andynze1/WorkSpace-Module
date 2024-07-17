variable "location" {
  description = "The Azure location where resources will be created"
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "public_subnet_name" {
  description = "The name of the public subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "The name of the private subnet"
  type        = string
}

variable "my_ip_address" {
  description = "Your IP address with a /32 subnet mask"
  type        = string
  default     = "146.85.136.101/32"
}
