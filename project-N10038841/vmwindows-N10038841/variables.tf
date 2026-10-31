variable "tags" {
  type = map(string)
}

variable "windows_avs" {}

variable "location" {}

variable "resource_group_name" {}

variable "nb_count" {
  type = number
}
variable "vm_size" {}

variable "subnet_id" {}

variable "windows_os_image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "windows_caching" {}

variable "windows_storage_account_type" {}

variable "windows_disk_size_gb" {
  type = number
}
variable "storage_account_primary_blob_endpoint" {}
variable "ScheduledScanSettings" {
  type = map(string)
}
variable "antimalware_name" {}
variable "antimalware_publisher" {}
variable "antimalware_type" {}
variable "antimalware_type_handler_version" {}