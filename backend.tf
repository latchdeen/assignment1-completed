terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateRG"
    storage_account_name = "tfstatelab22"
    container_name       = "tfstatefiles"
    key                  = "tfstate"
    access_key           = "6u4HnA03K9q0Jr/01PIRo/WzxfDAUcwyaNRab9E61ViZkm4167d0r46+qWgwZEDeRCItf0fpUtSZ7O9hZ/Ic8A=="

  }
}
