resource "null_resource" "linux_provisioner" {
  for_each   = var.linux_vms
  depends_on = [azurerm_linux_virtual_machine.linux_vm]

  connection {
    type        = "ssh"
    user        = var.linux_admin_username
    private_key = file("~/.ssh/id_rsa")
    host        = azurerm_public_ip.linux_pip[each.key].ip_address
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = ["hostname"]
  }
}
