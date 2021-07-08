variable "rg_name" {}

variable "location" {
  default = "canadaeast"
}

variable "win_vm_id" {}

variable "linux_vm_id" {}

variable "win_vm_name" {
  type    = map(string)
  default = {}
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

variable "data_disk_attr" {
  type = map(string)
  default = {
    data_disk_type          = "Premium_LRS"
    data_disk_create_option = "Empty"
    data_disk_size          = "10"
    data_disk_caching       = "ReadWrite"
  }
}


