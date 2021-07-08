# Resource Group Creation Module
module "rgroup" {
  source  = "./modules/rgroup"
  rg_name = var.rg01
}

# Network Creation Module
module "network" {
  source  = "./modules/network"
  rg_name = var.rg01
  depends_on = [
    module.rgroup
  ]
}

# Common Elements Creation Module
module "common" {
  source  = "./modules/common"
  rg_name = var.rg01
  depends_on = [
    module.rgroup
  ]
}

# Linux VM Creation Module
module "vmlinux" {
  source         = "./modules/vmlinux"
  linux_nb_count = 2
  rg_name        = var.rg01
  linux_vm_name  = var.linux_vms
  storage_act    = module.common.StorageAct
  subnet_id      = module.network.Subnet1.id
  depends_on = [
    module.rgroup,
    module.common,
    module.network
  ]
}

# Windows VM Creation Module
module "windows" {
  source           = "./modules/windows"
  windows_nb_count = 1
  rg_name          = var.rg01
  win_vm_name      = var.win_vms
  storage_act      = module.common.StorageAct
  subnet_id        = module.network.Subnet1.id
  depends_on = [
    module.rgroup,
    module.common,
    module.network
  ]
}

# Data Disk Creation Module
module "datadisk" {
  source        = "./modules/datadisk"
  rg_name       = var.rg01
  win_vm_name   = var.win_vms
  linux_vm_name = var.linux_vms
  win_vm_id     = module.windows.VM-Win
  linux_vm_id   = module.vmlinux.VM-Linux
  depends_on = [
    module.rgroup,
    module.vmlinux,
    module.windows
  ]
}

# LoadBalancer Creation Module
module "loadbalancer" {
  source        = "./modules/loadbalancer"
  rg_name       = var.rg01
  linux_vm_name = var.linux_vms
  linux_vm_PIP  = module.vmlinux.PublicIP-LinuxID
  subnet_id     = module.network.Subnet1.id
  VM_LinuxNIC   = module.vmlinux.VMLinux-NIC
  depends_on = [
    module.rgroup
  ]
}

# DataBase Creation Module
module "database" {
  source  = "./modules/database"
  rg_name = var.rg01
  depends_on = [
    module.rgroup
  ]
}
