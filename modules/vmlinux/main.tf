# Linux - Availability Set
resource "azurerm_availability_set" "avs_linux" {
  name                         = var.linux_avs
  resource_group_name          = var.rg_name
  location                     = var.location
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true

  tags = {
    environment = "Production"
  }
}

# Linux - Public IP
resource "azurerm_public_ip" "pip_linux" {
  for_each                = var.linux_vm_name
  name                    = "${each.key}-pip"
  resource_group_name     = var.rg_name
  location                = var.location
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
  domain_name_label       = each.key
  sku                     = "standard"
  tags                    = local.assignment01_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Linux - Network Interface
resource "azurerm_network_interface" "nic_linux" {
  for_each            = var.linux_vm_name
  name                = "${each.key}-nic"
  resource_group_name = var.rg_name
  location            = var.location
  tags                = local.assignment01_tags

  ip_configuration {
    name                          = each.key
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_linux[each.key].id
  }
  depends_on = [
    azurerm_public_ip.pip_linux
  ]
  lifecycle {
    create_before_destroy = true
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Virtual Machine - Linux
resource "azurerm_linux_virtual_machine" "vm_linux" {
  for_each              = var.linux_vm_name
  name                  = each.key
  computer_name         = each.key
  size                  = each.value
  location              = var.location
  resource_group_name   = var.rg_name
  admin_username        = "auto"
  tags                  = local.assignment01_tags
  network_interface_ids = [azurerm_network_interface.nic_linux[each.key].id]
  #disable_password_authentication = true

  admin_ssh_key {
    username   = "auto"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  boot_diagnostics {
    storage_account_uri = var.storage_act.primary_blob_endpoint
  }

  os_disk {
    name                 = each.key
    caching              = var.linux_vm_os_disk_attr["los_disk_caching"]
    storage_account_type = var.linux_vm_os_disk_attr["los_storage_account_type"]
    disk_size_gb         = var.linux_vm_os_disk_attr["los_disk_size"]
  }

  source_image_reference {
    publisher = var.linux_vm_os_src_img_ref["los_img_publisher"]
    offer     = var.linux_vm_os_src_img_ref["los_img_offer"]
    sku       = var.linux_vm_os_src_img_ref["los_img_sku"]
    version   = var.linux_vm_os_src_img_ref["los_img_version"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

