# Azure Provider source and version being used

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.67.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
features {}
# More information on the authentication methods supported by
# the AzureRM Provider can be found here:
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
tenant_id = var.tenant_id
client_id = var.client_id
client_secret = var.client_secret
subscription_id = var.subscription_id
}

# Create a resource group
resource "azurerm_resource_group" "resource_group" {
name = var.resource_group_name
location = var.resource_group_location
}

resource "azurerm_app_service_plan" "ASP-TerraForm" {
  name                = var.azurerm_app_service_plan_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  sku {
    tier = var.azurerm_app_service_plan_tier
    size = var.azurerm_app_service_plan_size
  }
}

resource "azurerm_app_service" "AS-Terraform" {
  name                = var.azurerm_app_service_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  app_service_plan_id = azurerm_app_service_plan.ASP-TerraForm.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:${azurerm_sql_server.test.fully_qualified_domain_name} Database=${azurerm_sql_database.test.name};User ID=${azurerm_sql_server.test.administrator_login};Password=${azurerm_sql_server.test.administrator_login_password};Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_sql_server" "test" {
  name                         = var.azurerm_sql_server_name
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = azurerm_resource_group.resource_group.location
  version                      = var.azurerm_sql_server_version
  administrator_login          = var.azurerm_sql_server_login
  administrator_login_password = var.azurerm_sql_server_loginpwd
}

resource "azurerm_sql_database" "test" {
  name                = var.azurerm_sql_database_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  server_name         = azurerm_sql_server.test.name

  tags = {
    environment = "dev"
  }
}