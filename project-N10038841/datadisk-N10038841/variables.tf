variable "resource_group_name" {}

variable "location" {}

variable "vm_ids" {
  type = list(string)
}

variable "disk_size_gb" {
  description = "Size of each managed data disk in GB."
  type        = number
  default     = 10
}

variable "tags" {
  type = map(string)
}