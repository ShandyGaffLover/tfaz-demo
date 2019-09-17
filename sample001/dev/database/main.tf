resource "azurerm_resource_group" "test" {
  name     = "database"
  location = "West Europe"
}
resource "azurerm_sql_server" "test" {
  name                         = "__sql_server_name__"
  resource_group_name          = "${azurerm_resource_group.test.name}"
  location                     = "West US"
  version                      = "12.0"
  administrator_login          = "__admin__"
  administrator_login_password = "__password__"
  lifecycle {
    ignore_changes = [
      "administrator_login_password",
    ]
  }
}

resource "azurerm_sql_database" "test" {
  name                = "tfaz-demo"
  resource_group_name = "${azurerm_resource_group.test.name}"
  location            = "West US"
  server_name         = "${azurerm_sql_server.test.name}"

  tags = {
    environment = "dev"
  }
}
