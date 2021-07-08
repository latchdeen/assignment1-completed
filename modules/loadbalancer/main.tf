# Loadbalancer - Public IP Allocation
resource "azurerm_public_ip" "pip_linux1" {
  name                = "PublicIPForLB"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "standard"
  tags                = local.assignment01_tags
}

# Loadbalancer Creation
resource "azurerm_lb" "linux_lb" {
  name                = "linux_lb01"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pip_linux1.id
  }
  tags = local.assignment01_tags
}

# Loadbalancer - Pool Creation
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.linux_lb.id
  name            = "BackEndAddressPool"
  lifecycle {
    ignore_changes = all
  }
}

# resource "azurerm_network_interface" "lb_nic" {
#   name                = "lb-nic"
#   resource_group_name = var.rg_name
#   location            = var.location

#   ip_configuration {
#     name                          = "testconfiguration1"
#     subnet_id                     = var.subnet_id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_assoc" {
#   network_interface_id    = azurerm_network_interface.lb_nic.id
#   ip_configuration_name   = "testconfiguration1"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
# }

# resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_assoc" {
#   count                   = length(var.linux_vm_name)
#   network_interface_id    = var.VM_LinuxNIC[count.index]
#   ip_configuration_name   = "${keys(var.linux_vm_name)[count.index]}-nic-ip"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
# }

# Loadbalancer - Associate VMs to Pool
resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_assoc" {
  count                   = length(var.linux_vm_name)
  network_interface_id    = var.VM_LinuxNIC[count.index].id
  ip_configuration_name   = keys(var.linux_vm_name)[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

# Loadbalancer - Allow SSH and RDP to VMs
resource "azurerm_lb_rule" "rule1" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.linux_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backend_pool.id
  probe_id                       = azurerm_lb_probe.probe1.id
}

# Loadbalancer - SSH probe health check
resource "azurerm_lb_probe" "probe1" {
  resource_group_name = var.rg_name
  loadbalancer_id     = azurerm_lb.linux_lb.id
  name                = "ssh-running-probe"
  port                = 22
}

