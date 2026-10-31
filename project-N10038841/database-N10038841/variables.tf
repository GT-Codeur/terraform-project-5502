variable "resource_group_name" {}

variable "location" {}

variable "server_name" {
  type        = string

  validation {
    condition = (
      length(var.server_name) >= 3 &&
      length(var.server_name) <= 63 &&
      can(regex("^[a-z0-9-]+$", var.server_name)) &&
      can(regex("^[a-z0-9]", var.server_name)) &&
      can(regex("[a-z0-9]$", var.server_name))
    )
    error_message = "The server name must be 3–63 characters, contain only lowercase letters, numbers, and hyphens, and start and end with a letter or number."
  }
}

variable "administrator_login" {
  type        = string
  default     = "pgadminuser"
}

variable "administrator_password" {
  type        = string
  sensitive   = true
}

variable "postgresql_version" {
  type        = string
  default     = "16"
}

variable "sku_name" {
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  type        = number
  default     = 7
}

variable "tags" {
  type        = map(string)
}