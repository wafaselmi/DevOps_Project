resource "azurerm_resource_group" "dad" {
  name     = "dad"
  location = "France Central"

  tags = {
    environment = "Development"
  }
}

resource "azurerm_storage_account" "dad-storaccount" {
  name                     = "terraformstateconv"
  resource_group_name      = azurerm_resource_group.dad.name
  location                 = azurerm_resource_group.dad.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "dad-storcontainer" {
  name                  = "dad-storcontainer"
  storage_account_name  = azurerm_storage_account.dad-storaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "dad-storblob" {
  name                   = "dad.json"
  storage_account_name   = azurerm_storage_account.dad-storaccount.name
  storage_container_name = azurerm_storage_container.dad-storcontainer.name
  type                   = "Block"
}