terraform {
  backend "azurerm" {
    resource_group_name  = "__tfbackend_resource_group_name__"
    storage_account_name  = "__tfbackend_storage_account_name__"
    container_name        = "__tfbackend_container_name__"
    key                   = "sample001/dev/database"
  }
}