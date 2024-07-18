locals {
  address_space = {
    stage = "10.0.0.0/16"
    prod  = "10.1.0.0/16"
  }
  public_subnet = {
    stage = cidrsubnet(local.address_space.stage, 8, 1) # 10.0.1.0/24
    prod  = cidrsubnet(local.address_space.prod, 8, 1)  # 10.1.1.0/24
  }
  private_subnet = {
    stage = cidrsubnet(local.address_space.stage, 8, 2) # 10.0.2.0/24
    prod  = cidrsubnet(local.address_space.prod, 8, 2)  # 10.1.2.0/24
  }
  network_security_group_rules = [
    {
      priority               = 200
      destination_port_range = "22"
      source_address_prefix  = var.my_ip_address
    },
    {
      priority               = 300
      destination_port_range = "8080"
    },
    {
      priority               = 400
      destination_port_range = "8081"
    },
    {
      priority               = 500
      destination_port_range = "9000"
    },
    {
      priority               = 700
      destination_port_range = "80"
    },
    {
      priority               = 800
      destination_port_range = "3000"
    },
    {
      priority               = 900
      destination_port_range = "443"
    },
  ]
}
