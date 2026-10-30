variable "linux_avs" {}
variable "location" {}
variable "resource_group" {}
variable "linux_vms" {}
variable "linux_name" {}
variable "sku" {}
variable "tags" {
  type = map(string)
}
variable "dns_label_suffix" {}
variable "linux_size" {}
variable "linux_admin_username" {}
variable "linux_public_key" {}
variable "linux_caching" {}
variable "linux_storage_account_type" {}
variable "linux_disk_size_gb" {}
variable "linux_publisher" {}
variable "linux_offer" {}
variable "linux_sku" {}
variable "linux_version" {}
variable "subnet_id" {}
variable "storage_account_primary_blob_endpoint" {}

variable "network_watcher_name" {}
variable "network_watcher_publisher" {}
variable "network_watcher_type" {}
variable "network_watcher_type_handler_version" {}

variable "azure_monitor_name" {}
variable "azure_monitor_publisher" {}
variable "azure_monitor_type" {}
variable "azure_monitor_type_handler_version" {}