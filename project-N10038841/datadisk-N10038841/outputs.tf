output "data_disk_ids" {
  value = azurerm_managed_disk.data_disk[*].id
}

output "data_disk_names" {
  value = azurerm_managed_disk.data_disk[*].name
}

output "attached_vm_ids" {
  value = var.vm_ids
}

output "disk_attachment_ids" {
  value = azurerm_virtual_machine_data_disk_attachment.disk_attachment[*].id
}