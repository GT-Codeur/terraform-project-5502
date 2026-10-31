output "avset_name" {
  value = azurerm_availability_set.windows_avset.name
}

output "windows_network_interface_cards" {
  value = [for nic in azurerm_network_interface.windows_nic : nic.name]
}

output "windows_vm_ids" {
  value = [for vm in azurerm_windows_virtual_machine.windows_vm : vm.id]
}

output "windows_vm_hostnames" {
  value = [for vm in azurerm_windows_virtual_machine.windows_vm : vm.name]
}

output "windows_vm_fqdns" {
  value = [for pip in azurerm_public_ip.windows_pip : pip.fqdn]
}

output "windows_public_ip_address" {
  value = [for pip in azurerm_public_ip.windows_pip : pip.ip_address]
}

output "windows_private_ip_address" {
  value = [for nic in azurerm_network_interface.windows_nic : nic.private_ip_address]
}

