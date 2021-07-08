# Windowns-Disk
resource "azurerm_managed_disk" "win_data_disk" {
  for_each             = var.win_vm_name
  name                 = "${each.key}-disk01"
  resource_group_name  = var.rg_name
  location             = var.location
  storage_account_type = var.data_disk_attr["data_disk_type"]
  create_option        = var.data_disk_attr["data_disk_create_option"]
  disk_size_gb         = var.data_disk_attr["data_disk_size"]
  tags                 = local.assignment01_tags
}

# Attach Disk to Windows VM
resource "azurerm_virtual_machine_data_disk_attachment" "win_data_disk_attach" {
  count              = length(var.win_vm_name)
  managed_disk_id    = azurerm_managed_disk.win_data_disk[keys(var.win_vm_name)[count.index]].id
  virtual_machine_id = var.win_vm_id[count.index]
  lun                = "10"
  caching            = var.data_disk_attr["data_disk_caching"]
  depends_on         = [azurerm_managed_disk.win_data_disk]
}

# Linux-Disk
resource "azurerm_managed_disk" "linux_data_disk" {
  for_each             = var.linux_vm_name
  name                 = "${each.key}-disk01"
  resource_group_name  = var.rg_name
  location             = var.location
  storage_account_type = var.data_disk_attr["data_disk_type"]
  create_option        = var.data_disk_attr["data_disk_create_option"]
  disk_size_gb         = var.data_disk_attr["data_disk_size"]
  tags                 = local.assignment01_tags
}

# Attach Disk to Linux VM
resource "azurerm_virtual_machine_data_disk_attachment" "linux_data_disk_attach" {
  count              = length(var.linux_vm_name)
  managed_disk_id    = azurerm_managed_disk.linux_data_disk[keys(var.linux_vm_name)[count.index]].id
  virtual_machine_id = var.linux_vm_id[count.index]
  lun                = "10"
  caching            = var.data_disk_attr["data_disk_caching"]
  depends_on         = [azurerm_managed_disk.linux_data_disk]
}
