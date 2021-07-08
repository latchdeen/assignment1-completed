# Windows - Availability Set
resource "azurerm_availability_set" "avs_windows" {
  name                        = var.avs_windows
  location                    = var.location
  resource_group_name         = var.rg_name
  platform_fault_domain_count = 2

  tags = {
    environment = "Production"
  }
}

# Windows - Public IP Allocation
resource "azurerm_public_ip" "pip_win" {
  for_each                = var.win_vm_name
  name                    = each.key
  location                = var.location
  resource_group_name     = var.rg_name
  domain_name_label       = each.key
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
  tags                    = local.assignment01_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Windows - NIC
resource "azurerm_network_interface" "nic_win" {
  for_each            = var.win_vm_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = local.assignment01_tags

  ip_configuration {
    name                          = "${each.key}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_win[each.key].id
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Windows - VM Creation
resource "azurerm_windows_virtual_machine" "vm_win" {
  for_each              = var.win_vm_name
  name                  = each.key
  location              = var.location
  resource_group_name   = var.rg_name
  computer_name         = each.key
  size                  = each.value
  admin_username        = var.win_vm_admin_username
  admin_password        = var.win_vm_admin_pass
  tags                  = local.assignment01_tags
  network_interface_ids = [azurerm_network_interface.nic_win[each.key].id]

  os_disk {
    name                 = each.key
    caching              = var.win_vm_os_disk_attr["los_disk_caching"]
    storage_account_type = var.win_vm_os_disk_attr["los_storage_account_type"]
    disk_size_gb         = var.win_vm_os_disk_attr["los_disk_size"]
  }

  source_image_reference {
    publisher = var.win_vm_os_src_img_ref["los_img_publisher"]
    offer     = var.win_vm_os_src_img_ref["los_img_offer"]
    sku       = var.win_vm_os_src_img_ref["los_img_sku"]
    version   = var.win_vm_os_src_img_ref["los_img_version"]
  }

  boot_diagnostics {
    storage_account_uri = var.storage_act.primary_blob_endpoint
  }

  lifecycle {
    create_before_destroy = true
  }
}

# resource "azurerm_managed_disk" "data_disk" {
#   for_each             = var.win_vm_name
#   name                 = "${each.key}-disk01"
#   resource_group_name  = var.rg_name
#   location             = var.location
#   storage_account_type = var.data_disk_attr["data_disk_type"]
#   create_option        = var.data_disk_attr["data_disk_create_option"]
#   disk_size_gb         = var.data_disk_attr["data_disk_size"]
#   tags                 = local.assignment01_tags
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach" {
#   for_each           = var.win_vm_name
#   managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
#   virtual_machine_id = azurerm_windows_virtual_machine.vm_win[each.key].id
#   lun                = "10"
#   caching            = var.data_disk_attr["data_disk_caching"]
#   depends_on         = [azurerm_managed_disk.data_disk]
# }

# Windows - Antimalware Extension
resource "azurerm_virtual_machine_extension" "vmantivirus" {
  for_each = var.win_vm_name
  name     = "Antimalware"

  virtual_machine_id         = azurerm_windows_virtual_machine.vm_win[each.key].id
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = "true"
  depends_on = [
    azurerm_windows_virtual_machine.vm_win,
    null_resource.provisioner_windows
  ]
  settings = <<SETTINGS
{
"AntimalwareEnabled": true,
"RealtimeProtectionEnabled": "true",
"ScheduledScanSettings": {
"isEnabled": "true",
"day": "1",
"time": "120",
"scanType": "Quick"
},
"Exclusions": {
"Extensions": "",
"Paths": "",
"Processes": ""
}
}
SETTINGS

  tags = local.assignment01_tags
}

