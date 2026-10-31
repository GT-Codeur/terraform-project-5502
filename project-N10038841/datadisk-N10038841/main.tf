resource "azurerm_managed_disk" "data_disk" {
  count = length(var.vm_ids)

  name                 = "data-disk-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  count = length(var.vm_ids)

  managed_disk_id    = azurerm_managed_disk.data_disk[count.index].id
  virtual_machine_id = var.vm_ids[count.index]

  lun     = count.index
  caching = "ReadWrite"
}