output "avset" {
  value = azurerm_availability_set.avset.name
}

output "linux_vm_ids" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.id]
}

output "linux_nic_ids" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.id]
}

output "linux_ip_conf_names" {
  value = [for ip_name in azurerm_network_interface.linux_nic : ip_name.ip_configuration[0].name]
}

output "linux_private_ip" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.private_ip_address]
}

output "linux_public_ip" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.ip_address]
}

output "linux_hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.name]
}

output "linux_FQDNs" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.fqdn]
}