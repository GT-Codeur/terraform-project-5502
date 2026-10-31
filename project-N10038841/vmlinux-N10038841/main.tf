resource "azurerm_availability_set" "avset" {
  name                = var.linux_avs
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.linux_vms
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group
  zones               = [each.value.zone]
  sku                 = var.sku

  allocation_method = "Static"

  domain_name_label = "dns-${each.key}-${var.dns_label_suffix}"
  tags              = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.linux_vms
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "${each.key}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.linux_vms
  name                = each.key
  computer_name       = each.key
  location            = var.location
  resource_group_name = var.resource_group
  availability_set_id = azurerm_availability_set.avset.id
  depends_on          = [azurerm_availability_set.avset]

  size           = var.linux_size
  admin_username = var.linux_admin_username

  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id
  ]

  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file(var.linux_public_key)
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = var.linux_caching
    storage_account_type = var.linux_storage_account_type
    disk_size_gb         = var.linux_disk_size_gb
  }

  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.linux_version
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_primary_blob_endpoint
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each = var.linux_vms

  name               = var.network_watcher_name
  virtual_machine_id = azurerm_linux_virtual_machine.linux_vm[each.key].id

  publisher            = var.network_watcher_publisher
  type                 = var.network_watcher_type
  type_handler_version = var.network_watcher_type_handler_version

  auto_upgrade_minor_version = true

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each = var.linux_vms

  name               = var.azure_monitor_name
  virtual_machine_id = azurerm_linux_virtual_machine.linux_vm[each.key].id

  publisher            = var.azure_monitor_publisher
  type                 = var.azure_monitor_type
  type_handler_version = var.azure_monitor_type_handler_version

  auto_upgrade_minor_version = false
  automatic_upgrade_enabled  = false

  tags = var.tags
}