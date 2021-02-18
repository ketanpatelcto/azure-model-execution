# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.prefix}resourcegroup"
  location = var.location
}

resource "azurerm_storage_account" "storageacct" {
  name                     = "${var.prefix}storageacct"
  resource_group_name      = azurerm_resource_group.resourcegroup.name
  location                 = azurerm_resource_group.resourcegroup.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  network_rules {
    default_action = "Deny"
    ip_rules       = [var.mypublicip]
  }
}

resource "azurerm_storage_share" "storageshare" {
    name                    = "${var.prefix}storageshare"
    storage_account_name    = azurerm_storage_account.storageacct.name
    quota                   = 1
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.prefix}keyvault"
  location                    = azurerm_resource_group.resourcegroup.location
  resource_group_name         = azurerm_resource_group.resourcegroup.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "keyvaultaccesspolicy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]

  storage_permissions = [
    "get",
  ]
}
/*
resource "azurerm_sql_server" "sqlserver" {
  name                         = "${var.prefix}sqlserver"
  resource_group_name          = azurerm_resource_group.resourcegroup.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_sql_database" "sqldatabase" {
  name                = "${var.prefix}sqldatabase"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = var.location
  server_name         = azurerm_sql_server.sqlserver.name
}
*/
resource "null_resource" "uploadfile" {
    provisioner "local-exec" {
        command = <<-EOT
        $storageAcct = Get-AzStorageAccount -ResourceGroupName "${azurerm_resource_group.resourcegroup.name}" -Name "${azurerm_storage_account.storageacct.name}"
        Set-AzStorageFileContent `
        -Context $storageAcct.Context `
        -ShareName "${azurerm_storage_share.storageshare.name}" `
        -Source ".\data\loan_data.csv" `
        -Path "loan_data.csv"

        EOT

        interpreter = ["PowerShell", "-Command"]
    }
}