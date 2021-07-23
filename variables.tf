variable "tenant_id" {
type = string
}
variable "client_id" {
type = string
}
variable "client_secret" {
type = string
sensitive = true
}
variable "subscription_id" {
type = string
}
variable "resource_group_name" {
type = string
}
variable "resource_group_location" {
type = string
}
variable "azurerm_app_service_plan_name" {
type = string
}
variable "azurerm_app_service_plan_tier" {
type = string
}
variable "azurerm_app_service_plan_size" {
type = string
}
variable "azurerm_app_service_name" {
type = string
}
variable "azurerm_sql_server_name" {
type = string
}
variable "azurerm_sql_server_version" {
type = string
}
variable "azurerm_sql_server_login" {
type = string
}
variable "azurerm_sql_server_loginpwd" {
type = string
sensitive = true
}
variable "azurerm_sql_database_name" {
type = string
}