resource "azurerm_log_analytics_workspace" "log_analytics_wsp" {
  name                = var.log_ana_wps_name
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = var.vault_name
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.sku
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
}