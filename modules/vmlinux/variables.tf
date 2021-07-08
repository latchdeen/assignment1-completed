variable "rg_name" {}

variable "subnet_id" {}

variable "storage_act" {}

variable "location" {
  default = "canadaeast"
}

variable "linux_vm_name" {
  type    = map(string)
  default = {}
}

locals {
  assignment01_tags = {
    Name           = "Terraform Group Project"
    GroupMembers   = "Latchman Deen & Frederick Christopher"
    ExpirationDate = "2021-07-31"
    Environment    = "Lab"
  }
}

variable "linux_avs" {
  default = "linux_avs"
}

variable "linux_nb_count" {}


variable "linux_vm_admin_username" {
  default = "auto"
}

variable "linux_vm_admin_ssh_pub_key" {
  default = "/home/auto/.ssh/id_rsa.pub"
}

variable "linux_vm_os_disk_attr" {
  type = map(string)
  default = {
    los_storage_account_type = "Premium_LRS"
    los_disk_size            = "32"
    los_disk_caching         = "ReadWrite"
  }
}

variable "linux_vm_os_src_img_ref" {
  type = map(string)
  default = {
    los_img_publisher = "OpenLogic"
    los_img_offer     = "CentOS"
    los_img_sku       = "7.5"
    los_img_version   = "latest"
  }
}

