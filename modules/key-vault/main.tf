terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.22"
    }
  }
}

resource "azurecaf_name" "key_vault" {
  random_length = "15"
  resource_type = "azurerm_key_vault"
  suffixes      = [var.environment]
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "application" {
  name                = azurecaf_name.key_vault.result
  resource_group_name = var.resource_group
  location            = var.location

  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 90

  sku_name = "standard"

  tags = {
    "environment"      = var.environment
    "application-name" = var.application_name
  }
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.application.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Set",
    "Get",
    "List",
    "Delete"
  ]
}

resource "azurerm_key_vault_secret" "cosmosdb_mongodb_uri" {
  name         = "cosmosdb-mongodb-uri"
  value        = var.cosmosdb_mongodb_uri
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

resource "azurerm_key_vault_secret" "aws_region" {
  name         = "aws-region"
  value        = var.aws_region
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

resource "azurerm_key_vault_secret" "aws_access_key_id" {
  name         = "aws-access-key-id"
  value        = var.aws_access_key_id
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

resource "azurerm_key_vault_secret" "aws_secret_access_key" {
  name         = "aws-secret-access-key"
  value        = var.aws_secret_access_key
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

resource "azurerm_key_vault_secret" "aws_cognito_user_pool_id" {
  name         = "aws-cognito-user-pool-id"
  value        = var.aws_cognito_user_pool_id
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

resource "azurerm_key_vault_secret" "aws_cognito_app_client_id" {
  name         = "aws-cognito-app-client-id"
  value        = var.aws_cognito_app_client_id
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

resource "azurerm_key_vault_secret" "aws_cognito_user_pool_client_id" {
  name         = "aws-cognito-user-pool-client-id"
  value        = var.aws_cognito_user_pool_client_id
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

resource "azurerm_key_vault_secret" "aws_cognito_app_client_secret" {
  name         = "aws-cognito-app-client-secret"
  value        = var.aws_cognito_app_client_secret
  key_vault_id = azurerm_key_vault.application.id

  depends_on = [ azurerm_key_vault_access_policy.client ]
}

