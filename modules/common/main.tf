# resource "azurerm_log_analytics_workspace" "log-analytics" {
#   name                = "log-analytics01"
#   location            = var.location
#   resource_group_name  = var.rg_name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

# Recovery Services Vault Creation
resource "azurerm_recovery_services_vault" "vault" {
  name                = "recov-svc-vault"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  soft_delete_enabled = true
}

# Storage Account Creation
resource "azurerm_storage_account" "storageact01" {
  name                     = "vmstorageact01"
  location                 = var.location
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Account Container Creation
resource "azurerm_storage_container" "storagecont01" {
  name                  = "storagecont01"
  storage_account_name  = azurerm_storage_account.storageact01.name
  container_access_type = "private"
}

# Storage Account and Container Association
resource "azurerm_storage_blob" "storageblob01" {
  name                   = "storage.txt"
  storage_account_name   = azurerm_storage_account.storageact01.name
  storage_container_name = azurerm_storage_container.storagecont01.name
  type                   = "Block"
  source                 = "${path.module}/storage.txt"
}


