resource "azurerm_availability_set" "avset" {
  name                = var.linux_avs
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_public_ip" "linux_pip" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index}-pip"
  location            = var.location
  resource_group_name = var.rg_linux

  allocation_method = "Static"

  domain_name_label = "dns-${var.linux_name}-${count.index}"
  tags              = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index}-nic"
  location            = var.location
  resource_group_name = var.rg_linux

  ip_configuration {
    name                          = "${var.linux_name}-${count.index}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[count.index].id
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count               = var.nb_count
  name                = "${var.linux_name}-${count.index}"
  computer_name       = "${var.linux_name}-${count.index}"
  location            = var.location
  resource_group_name = var.rg_linux
  availability_set_id = azurerm_availability_set.avset.id
  depends_on          = [azurerm_availability_set.avset]

  size           = var.linux_size
  admin_username = var.linux_admin_username

  network_interface_ids = [
    element(azurerm_network_interface.linux_nic[*].id, count.index)
  ]

  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file(var.linux_public_key)
  }

  os_disk {
    name                 = "${var.linux_name}-${count.index}-os-disk"
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

  tags = var.tags
}