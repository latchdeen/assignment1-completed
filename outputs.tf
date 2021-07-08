# Resource Group Output
output "ResourceGroup-Name" {
  value = module.rgroup.ResourceGroup.name
}

# Linux Output
output "VM-Linux-Hostname" {
  value = module.vmlinux.VM-Linux-Hostname
}

# # Linux Output
# output "VM-Linux" {
#   value = module.vmlinux.VM-Linux
# }

output "PublicIP-Linux" {
  value = module.vmlinux.PublicIP-Linux
}

output "PrivateIP-Linux" {
  value = module.vmlinux.PrivateIP-Linux
}

# output "VMLinux-NIC" {
#   value = module.vmlinux.VMLinux-NIC.id
# }

# Network Output
output "VirtualNetwork-Name" {
  value = module.network.VirtualNetwork.name
}

output "VirtualNetwork-Sapce" {
  value = module.network.VirtualNetwork.address_space
}

output "Subnet1-Name" {
  value = module.network.Subnet1.name
}

# output "Subnet1-ID" {
#   value = module.network.Subnet1.id
# }

output "Subnet1-AddressSpace" {
  value = module.network.Subnet1.address_prefixes
}

# Windows Output
output "VM-Win-Hostname" {
  value = module.windows.VM-Win-Hostname
}

# output "VM-Win" {
#   value = module.windows.VM-Win[0]
# }

output "PublicIP-Win" {
  value = module.windows.PublicIP-Win
}

output "PrivateIP-Win" {
  value = module.windows.PrivateIP-Win
}

# # VMs-IPs Output
# output "PublicIP_VMs-ID" {
#   value = module.vmlinux.PublicIP-LinuxID
# }

# LB Output
output "PublicIP-LB" {
  value = module.loadbalancer.PublicIP-LB.ip_address
}

output "LB_Name" {
  value = module.loadbalancer.PublicIP-LB.name
}

# DB Output
output "postgresql-DB" {
  value = module.database.postgresqlDB.name
}