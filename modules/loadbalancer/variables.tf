variable "rg_name" {}

variable "location" {
  default = "canadaeast"
}

variable "subnet_id" {}

variable "VM_LinuxNIC" {}

variable "linux_vm_PIP" {}

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
