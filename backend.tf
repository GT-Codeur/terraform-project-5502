terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten10038841RG"
    storage_account_name = "tfstaten10038841sa"
    container_name       = "tfstatefiles"
    key                  = "terraform.tfstate"
  }
}
