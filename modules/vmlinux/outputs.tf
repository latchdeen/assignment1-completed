output "VM-Linux" {
  value = values(azurerm_linux_virtual_machine.vm_linux)[*].id
}

output "VM-Linux-Hostname" {
  value = [values(azurerm_linux_virtual_machine.vm_linux)[*].name]
}

output "PublicIP-Linux" {
  value = [values(azurerm_linux_virtual_machine.vm_linux)[*].public_ip_address]
}

output "PublicIP-LinuxID" {
  value = values(azurerm_public_ip.pip_linux)[*].id
}

output "PrivateIP-Linux" {
  value = [values(azurerm_linux_virtual_machine.vm_linux)[*].private_ip_address]
}

output "VMLinux-NIC" {
  value = values(azurerm_network_interface.nic_linux)[*]
}
