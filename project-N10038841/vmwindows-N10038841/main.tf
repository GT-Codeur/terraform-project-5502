resource "azurerm_availability_set" "windows_avset" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  # Iterates over the windows_name map variable
  count = var.nb_count

  name                = "windows-vm-${count.index + 1}"
  computer_name       = "windowsvm${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  size = var.vm_size

  admin_username = "adminuser"
  admin_password = "P@ssw0rd1234!"

  availability_set_id = azurerm_availability_set.windows_avset.id

  # Maps each specific VM instance to its corresponding key-indexed network interface
  network_interface_ids = [
    azurerm_network_interface.windows_nic[count.index].id
  ]

  winrm_listener {
    protocol = "Http"
  }

  os_disk {
    name                 = "${count.index + 1}-os-disk"
    caching              = var.windows_caching
    storage_account_type = var.windows_storage_account_type
    disk_size_gb         = var.windows_disk_size_gb
  }

  source_image_reference {
    publisher = var.windows_os_image.publisher
    offer     = var.windows_os_image.offer
    sku       = var.windows_os_image.sku
    version   = var.windows_os_image.version
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_primary_blob_endpoint
  }

  tags = var.tags
}

resource "azurerm_network_interface" "windows_nic" {
  count = var.nb_count

  name                = "${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${count.index + 1}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.windows_pip[count.index].id
  }

  tags = var.tags
}

resource "azurerm_public_ip" "windows_pip" {
  count               = var.nb_count
  name                = "${count.index + 1}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"

  domain_name_label = "dns-win-${var.dns_label_suffix}"

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count = var.nb_count

  name               = var.antimalware_name
  virtual_machine_id = azurerm_windows_virtual_machine.windows_vm[count.index].id

  publisher            = var.antimalware_publisher
  type                 = var.antimalware_type
  type_handler_version = var.antimalware_type_handler_version

  auto_upgrade_minor_version = true

  settings = jsonencode({
    AntimalwareEnabled        = true
    RealtimeProtectionEnabled = "true"

    ScheduledScanSettings = var.ScheduledScanSettings
  })

  tags = var.tags
}