# Providers source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.31.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configuring the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Configuring the AWS Provider
provider "aws" {
  region = "us-east-1"
}



