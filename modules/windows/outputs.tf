output "VM-Win" {
  value = values(azurerm_windows_virtual_machine.vm_win)[*].id
}

output "VM-Win-Hostname" {
  value = [values(azurerm_windows_virtual_machine.vm_win)[*].name]
}

output "PublicIP-Win" {
  value = [values(azurerm_windows_virtual_machine.vm_win)[*].public_ip_address]
}

output "PrivateIP-Win" {
  value = [values(azurerm_windows_virtual_machine.vm_win)[*].private_ip_address]
}
