# output "LogAnalyticsWS" {
#   value = azurerm_log_analytics_workspace.log-analytics
# } 

output "RecoverySvcVault" {
  value = azurerm_recovery_services_vault.vault
}

output "StorageAct" {
  value = azurerm_storage_account.storageact01
}

