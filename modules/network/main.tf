# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet1
  resource_group_name = var.rg_name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
}

# Subnet 1 associated with Vnet
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet1_space
}

# Security Group 1
resource "azurerm_network_security_group" "nsg01" {
  name                = var.nsg1
  resource_group_name = var.rg_name
  location            = var.location

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["3389", "22"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Subnet-SecurityGroup Association with Subnet
resource "azurerm_subnet_network_security_group_association" "subnet1-nsga1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg01.id
}
