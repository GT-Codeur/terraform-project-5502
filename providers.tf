provider "azurerm" {
  features {}
  subscription_id = "0dc58b09-b8dd-4796-b0c3-7533bf65fe42"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }

    null = {
      source  = "hashicorp/null",
      version = "~> 3.2"
    }
  }
}
