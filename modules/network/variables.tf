variable "rg_name" {}

variable "location" {
  default = "canadaeast"
}

variable "vnet1" {
  default = "assignment01-vnet"
}

variable "subnet1_name" {
  default = "assignment01-subnet1"
}

variable "subnet1_space" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "nsg1" {
  default = "assignment01-nsg01"
}

locals {
  assignment01_tags = {
    Name           = "Terraform Group Project"
    GroupMembers   = "Latchman Deen & Frederick Christopher"
    ExpirationDate = "2021-07-31"
    Environment    = "Lab"
  }
}