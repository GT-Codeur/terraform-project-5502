variable "linux_avs" {}
variable "location" {}
variable "resource_group" {}
variable "nb_count" { type = number }
variable "linux_name" {}
variable "tags" {
  type = map(string)
}
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