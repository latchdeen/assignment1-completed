resource "null_resource" "provisioner_windows" {
  for_each = var.win_vm_name
  depends_on = [
    azurerm_windows_virtual_machine.vm_win
  ]

  provisioner "local-exec" {
    command = "uname -a"

    connection {
      type     = "winrm"
      user     = var.win_vm_admin_username
      password = var.win_vm_admin_pass
      host     = var.win_vm_name[each.key]
    }
  }
}