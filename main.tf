terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.32.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.22"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

locals {
  // If an environment is set up (dev, test, prod...), it is used in the application name
  environment = var.environment == "" ? "dev" : var.environment
}

resource "azurecaf_name" "resource_group" {
  name          = var.application_name
  resource_type = "azurerm_resource_group"
  suffixes      = [local.environment]
}

resource "azurerm_resource_group" "main" {
  name     = azurecaf_name.resource_group.result
  location = var.location

  tags = {
    "terraform"        = "true"
    "environment"      = local.environment
    "application-name" = var.application_name

    // Name of the Azure Storage Account that stores the Terraform state
    "terraform_storage_account" = var.terraform_storage_account
  }
}

module "application" {
  source           = "./modules/app-service"
  resource_group   = azurerm_resource_group.main.name
  application_name = var.application_name
  environment      = local.environment
  location         = var.location

  azure_application_insights_instrumentation_key = module.application-insights.azure_application_insights_instrumentation_key

  vault_id = module.key-vault.vault_id

  azure_cosmosdb_mongodb_database = module.cosmosdb-mongodb.azure_cosmosdb_mongodb_database
  azure_cosmosdb_mongodb_uri      = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/cosmosdb-mongodb-uri)"

  aws_region                      = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/aws-region)"
  aws_access_key_id               = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/aws-access-key-id)"
  aws_secret_access_key           = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/aws-secret-access-key)"
  aws_cognito_user_pool_id        = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/aws-cognito-user-pool-id)"
  aws_cognito_app_client_id       = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/aws-cognito-app-client-id)"
  aws_cognito_user_pool_client_id = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/aws-cognito-user-pool-client-id)"
  aws_cognito_app_client_secret   = "@Microsoft.KeyVault(SecretUri=${module.key-vault.vault_uri}secrets/aws-cognito-app-client-secret)"
}

module "frontend-application" {
  source           = "./modules/static-site"
  resource_group   = azurerm_resource_group.main.name
  application_name = var.application_name
  environment      = local.environment
  location         = var.location
}

module "application-insights" {
  source           = "./modules/application-insights"
  resource_group   = azurerm_resource_group.main.name
  application_name = var.application_name
  environment      = local.environment
  location         = var.location
}

module "key-vault" {
  source           = "./modules/key-vault"
  resource_group   = azurerm_resource_group.main.name
  application_name = var.application_name
  environment      = local.environment
  location         = var.location

  cosmosdb_mongodb_uri = module.cosmosdb-mongodb.azure_cosmosdb_mongodb_uri

  aws_region = var.AWS_REGION
  aws_access_key_id = var.AWS_ACCESS_KEY_ID
  aws_secret_access_key = var.AWS_SECRET_ACCESS_KEY
  aws_cognito_user_pool_id = var.AWS_COGNITO_USER_POOL_ID
  aws_cognito_app_client_id = var.AWS_COGNITO_APP_CLIENT_ID
  aws_cognito_user_pool_client_id =  var.AWS_COGNITO_USER_POOL_CLIENT_ID
  aws_cognito_app_client_secret = var.AWS_COGNITO_APP_CLIENT_SECRET
}

module "cosmosdb-mongodb" {
  source           = "./modules/cosmosdb-mongodb"
  resource_group   = azurerm_resource_group.main.name
  application_name = var.application_name
  environment      = local.environment
  location         = var.location
}
