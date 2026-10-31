resource "random_string" "dns_suffix" {
  length  = 6
  special = false
  upper   = false
}

module "rgroup-N10038841" {
  source              = "./project-N10038841/rgroup-N10038841"
  resource_group_name = "rgroup-N10038841"
  location            = "indiasouthcentral"
}

module "network-N10038841" {
  resource_group_name = module.rgroup-N10038841.resource_group_name
  location            = "indiasouthcentral"
  source              = "./project-N10038841/network-N10038841"

  virtual_network_name          = "N10038841-VNET"
  subnet_name                   = "N10038841-SUBNET"
  sg_name                       = "N10038841-nsg"
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_address_space          = ["10.0.1.0/24"]
}

module "common-N10038841" {
  source         = "./project-N10038841/common-N10038841"
  location       = "indiasouthcentral"
  resource_group = module.rgroup-N10038841.resource_group_name

  log_ana_wps_name         = "N10038841-log-analytics-workspace"
  vault_name               = "N10038841-recovery-vault"
  storage_account_name     = "storageaccountn10038841"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  sku                      = "Standard"
  tags                     = local.tags
}

module "vmlinux-N10038841" {
  resource_group             = module.rgroup-N10038841.resource_group_name
  location                   = "indiasouthcentral"
  source                     = "./project-N10038841/vmlinux-N10038841"
  subnet_id                  = module.network-N10038841.subnet_id
  linux_admin_username       = "n10038841"
  linux_avs                  = "linux-availability-set"
  linux_caching              = "ReadWrite"
  linux_disk_size_gb         = 32
  linux_name                 = "n10038841-u-vm1"
  linux_offer                = "CentOS"
  linux_public_key           = "/home/germainteg/.ssh/id_rsa.pub"
  linux_publisher            = "OpenLogic"
  linux_size                 = "Standard_B1s"
  linux_sku                  = "8_2-gen2"
  linux_storage_account_type = "Standard_LRS"
  linux_version              = "latest"
  dns_label_suffix           = random_string.dns_suffix.result

  network_watcher_name                 = "NetworkWatcherAgentLinux"
  network_watcher_publisher            = "Microsoft.Azure.NetworkWatcher"
  network_watcher_type                 = "NetworkWatcherAgentLinux"
  network_watcher_type_handler_version = "1.0"
  azure_monitor_name                   = "AzureMonitorLinuxAgent"
  azure_monitor_publisher              = "Microsoft.Azure.Monitor"
  azure_monitor_type                   = "AzureMonitorLinuxAgent"
  azure_monitor_type_handler_version   = "1.0"

  storage_account_primary_blob_endpoint = (
    module.common-N10038841.storage_account_primary_blob_endpoint
  )
  sku       = module.common-N10038841.sku
  linux_vms = local.linux_vms
  tags      = local.tags

}

module "vmwindows-N10038841" {
  resource_group_name = module.rgroup-N10038841.resource_group_name
  location            = "indiasouthcentral"
  source              = "./project-N10038841/vmwindows-N10038841"
  subnet_id           = module.network-N10038841.subnet_id
  windows_avs         = "windows-availability-set"
  nb_count            = 1
  windows_os_image = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
  windows_caching                  = "ReadWrite"
  windows_disk_size_gb             = 128
  windows_storage_account_type     = "StandardSSD_LRS"
  antimalware_name                 = "IaaSAntimalware"
  antimalware_publisher            = "Microsoft.Azure.Security"
  antimalware_type                 = "IaaSAntimalware"
  antimalware_type_handler_version = "1.5"
  ScheduledScanSettings            = local.ScheduledScanSettings
  storage_account_primary_blob_endpoint = (
    module.common-N10038841.storage_account_primary_blob_endpoint
  )
  vm_size = "Standard_B1s"
  tags = local.tags

}

module "datadisk-N10038841" {
  source = "./project-N10038841/datadisk-N10038841"

  resource_group_name = module.rgroup-N10038841.resource_group_name
  location            = "indiasouthcentral"

  vm_ids = concat(
    module.vmlinux-N10038841.linux_vm_ids,
    module.vmwindows-N10038841.windows_vm_ids
  )

  disk_size_gb = 10

  tags = local.tags
}

module "loadbalancer-N10038841" {
  source = "./project-N10038841/loadbalancer-N10038841"

  resource_group_name = module.rgroup-N10038841.resource_group_name
  location            = "indiasouthcentral"

  linux_nic_ids = module.vmlinux-N10038841.linux_nic_ids

  dns_label_suffix = random_string.dns_suffix.result

  tags = local.tags
}

module "database-N10038841" {
  source = "./project-N10038841/database-N10038841"

  resource_group_name = module.rgroup-N10038841.resource_group_name
  location            = "indiasouthcentral"

  server_name = "pg-humber-${random_string.dns_suffix.result}"

  administrator_login    = "pgadminuser"
  administrator_password = "P@ssw0rd1234!"

  postgresql_version = "16"
  sku_name           = "B_Standard_B1ms"
  storage_mb         = 32768

  backup_retention_days = 7

  tags = local.tags
}