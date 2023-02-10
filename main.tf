/* Create two users (one user will be your name, another user will be your trainer’s name) on Azure with Terraform. 
Use correct argument in your configuration to force your trainer to change their passwords when s/he logins. 
(Create it as a two different resource blocks) */

# user 1
resource "azuread_user" "user1" {
  user_principal_name = "jaldeep.patel@fdmgroup.com"
  display_name        = "Jaldeep Patel"
  mail_nickname       = "jpatel"
  password            = "JaldeepP@sswd15!"
}

# user 2
resource "azuread_user" "user2" {
  user_principal_name = "ibrahim.ozbekler@fdmgroup.com"
  display_name        = "Ibrahim Ozbekler"
  mail_nickname       = "iozbekler"
}

/* Create a Resource Group, Virtual Machine and Storage Account with Terraform. 
Use same Resource Group for every Azure resource. */

# resource group
resource "azurerm_resource_group" "resource_group1" {
    name = "${var.prefix}-resources"
    location = "eastus"
}

# storage account
resource "azurerm_storage_account" "storage-account1" {
    name = "storageaccount2"
    resource_group_name = azurerm_resource_group.resource_group1.name
    location = azurerm_resource_group.resource_group1.location
    account_tier = "Standard"
    account_replication_type = "LRS"

    tags = {
      name = "storage-account-2"
    }
}

# virtual machine
resource "azurerm_virtual_machine" "virtual-machine1" {
  name                  = "${var.prefix}-virtualmachine1"
  location              = azurerm_resource_group.resource_group1.location
  resource_group_name   = azurerm_resource_group.resource_group1.name
  network_interface_ids = [azurerm_network_interface.network-interface1.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "dev"
  }
}

# Additional resource are created because Virtual Machine requires "network_interface_ids" as a required parameter
resource "azurerm_virtual_network" "virtual-network1" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resource_group1.location
  resource_group_name = azurerm_resource_group.resource_group1.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet-1"
  resource_group_name  = azurerm_resource_group.resource_group1.name
  virtual_network_name = azurerm_virtual_network.virtual-network1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "network-interface1" {
  name                = "${var.prefix}-network-interface"
  location            = azurerm_resource_group.resource_group1.location
  resource_group_name = azurerm_resource_group.resource_group1.name

  ip_configuration {
    name                          = "ipconfiguration1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create four different users (usernames will be your classmates) on Aws by using `for_each` with Terraform
resource "aws_iam_user" "aws-users" {
  for_each = toset(var.username)
  name     = each.value
}

# Create two S3(Simple Storage Service) bucket using `count` with Terraform
resource "aws_s3_bucket" "s3-buckets" {
    count = length(var.bucket_list)
    bucket = var.bucket_list[count.index]
}
