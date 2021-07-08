variable "rg_name" {}

variable "location" {
  default = "canadaeast"
}

variable "win_vm_name" {
  type    = map(string)
  default = {}
}

variable "storage_act" {}

variable "subnet_id" {}

variable "win_vm_admin_username" {
  default = "adminuser"
}

variable "win_vm_admin_pass" {
  default = "P@$$w0rd1234!"
}

variable "win_vm_os_disk_attr" {
  type = map(string)
  default = {
    los_storage_account_type = "Standard_LRS"
    los_disk_size            = "127"
    los_disk_caching         = "ReadWrite"
  }
}

variable "win_vm_os_src_img_ref" {
  type = map(string)
  default = {
    los_img_publisher = "MicrosoftWindowsServer"
    los_img_offer     = "WindowsServer"
    los_img_sku       = "2019-Datacenter"
    los_img_version   = "latest"
  }
}

locals {
  assignment01_tags = {
    Name           = "Terraform Group Project"
    GroupMembers   = "Latchman Deen & Frederick Christopher"
    ExpirationDate = "2021-07-31"
    Environment    = "Lab"
  }
}

variable "windows_nb_count" {}

variable "avs_windows" {
  default = "avs_windows"
}

variable "data_disk_attr" {
  type = map(string)
  default = {
    data_disk_type          = "Premium_LRS"
    data_disk_create_option = "Empty"
    data_disk_size          = "10"
    data_disk_caching       = "ReadWrite"
  }
}