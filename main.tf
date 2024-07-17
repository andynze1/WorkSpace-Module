locals {
  env = terraform.workspace
}

module "network" {
  source                        = "./modules/network"
  resource_group                = var.resource_group
  location                      = var.location
  virtual_network_name          = var.virtual_network.name
  virtual_network_address_space = var.virtual_network.address_space
  public_subnet_name            = var.public_subnet_name
  private_subnet_name           = var.private_subnet_name
  my_ip_address                 = var.my_ip_address
}

module "vm" {
  source               = "./modules/vm"
  resource_group_name  = module.network.resource_group_name
  location             = module.network.location
  network_interface_id = module.network.network_interface_id
  build_server         = "build-server"
  vm_size              = "Standard_D2s_v3"
  public_subnet_id     = module.network.public_subnet_id
  private_subnet_id    = module.network.private_subnet_id
  virtual_network_name = module.network.virtual_network_name
}