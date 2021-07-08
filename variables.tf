variable "rg01" {
  default = "group4-assignment1-rg"
}

variable "win_vms" {
  type = map(string)
  default = {
    "humber3629-w-vm" = "Standard_B1ms"
  }
}

variable "linux_vms" {
  type = map(string)
  default = {
    "humber3629-c-vm1" = "Standard_B1ms"
    "humber3629-c-vm2" = "Standard_B1ms"
  }
}