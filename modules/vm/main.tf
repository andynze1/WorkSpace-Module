resource "azurerm_linux_virtual_machine" "build_server" {
  name                  = "${terraform.workspace}-build-server"
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.vm_size
  admin_username        = "${terraform.workspace}-user"
  admin_ssh_key {
    username   = "${terraform.workspace}-user"
    public_key = tls_private_key.linux-keypair.public_key_openssh
  }
  network_interface_ids = [var.network_interface_id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 40
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  custom_data = filebase64("${path.module}/app-scripts/install.sh")
  depends_on = [ var.resource_group_name ]
}

# Create SSH RSA key of size 4096 bits
resource "tls_private_key" "linux-keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Copy ssh key to local
resource "local_file" "linux-pem-key" {
  content         = tls_private_key.linux-keypair.private_key_pem
  filename        = "${terraform.workspace}-keypair.pem"
  file_permission = "0400"
  depends_on      = [tls_private_key.linux-keypair]
}
