output "log_ana_wps_name" {
  value = azurerm_log_analytics_workspace.log_analytics_wsp.name
}

output "vault_name" {
  value = azurerm_recovery_services_vault.vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "sku" {
  value = azurerm_recovery_services_vault.vault.sku
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}