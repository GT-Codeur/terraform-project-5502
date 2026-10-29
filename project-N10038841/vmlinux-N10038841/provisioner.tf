resource "terraform_data" "linux_provisioner" {
  count      = var.nb_count
  depends_on = [azurerm_linux_virtual_machine.linux_vm]

  connection {
    type        = "ssh"
    user        = var.linux_admin_username
    private_key = file("~/.ssh/id_rsa")
    host        = element(azurerm_public_ip.linux_pip[*].ip_address, count.index)
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = ["cat /etc/os-release"]
  }
}
