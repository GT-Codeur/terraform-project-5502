variable "resource_group_name" {}

variable "location" {}

variable "linux_nic_ids" {
  type = list(string)

  validation {
    condition     = length(var.linux_nic_ids) == 3
    error_message = "Exactly three Linux VM network interface IDs must be provided."
  }
}

variable "linux_ip_conf_names" {
  type = list(string)
}

variable "dns_label_suffix" {}

variable "tags" {
  type = map(string)
}