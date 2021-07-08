resource "null_resource" "provisioner_linux" {
  for_each = var.linux_vm_name
  depends_on = [
    azurerm_linux_virtual_machine.vm_linux
  ]

  provisioner "local-exec" {
    command = "uname -a"

    connection {
      type        = "ssh"
      host        = var.linux_vm_name[each.key]
      user        = var.linux_vm_admin_username
      private_key = file(var.linux_vm_admin_ssh_pub_key)
    }
  }
}