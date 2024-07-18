resource "azurerm_resource_group" "resource_group" {
  name     = "${terraform.workspace}-resource_group"
  location = var.location
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${terraform.workspace}-virtual_network_name"
  address_space       = [local.address_space[terraform.workspace]]
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  
  depends_on = [
    azurerm_resource_group.resource_group
  ]
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "${terraform.workspace}-public_subnet_name"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [local.public_subnet[terraform.workspace]]
  depends_on = [
    azurerm_virtual_network.virtual_network,
  ]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "${terraform.workspace}-private_subnet_name"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [local.private_subnet[terraform.workspace]]
  depends_on = [
    azurerm_virtual_network.virtual_network,
  ]
}

resource "azurerm_network_security_group" "security_group" {
  name                = "${terraform.workspace}-security_group"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dynamic "security_rule" {
    for_each = local.network_security_group_rules
    content {
      name                       = "Allow-${security_rule.value.destination_port_range}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = lookup(security_rule.value, "source_address_prefix", "*")
      destination_address_prefix = "*"
    }
  }
  depends_on = [
    azurerm_virtual_network.virtual_network
  ]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${terraform.workspace}-public_ip"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"

  depends_on = [ 
    azurerm_network_security_group.security_group,
  ]
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${terraform.workspace}-network_interface"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
   }
  depends_on = [ 
    azurerm_public_ip.public_ip 
  ]
}
resource "azurerm_network_interface_security_group_association" "networksgasso" {
  network_interface_id      = azurerm_network_interface.network_interface.id
  network_security_group_id = azurerm_network_security_group.security_group.id
  depends_on = [ 
    azurerm_network_interface.network_interface,
  ]
}

