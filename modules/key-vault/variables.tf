variable "resource_group" {
  type        = string
  description = "The resource group"
}

variable "application_name" {
  type        = string
  description = "The name of your application"
}

variable "environment" {
  type        = string
  description = "The environment (dev, test, prod...)"
  default     = "dev"
}

variable "location" {
  type        = string
  description = "The Azure region where all resources in this example should be created"
}

variable "cosmosdb_mongodb_uri" {
  type        = string
  description = "The Cosmos DB connection string"
}

variable "aws_region" {
  type        = string
  description = "Aws Region variable from .env"
}

variable "aws_access_key_id" {
  type        = string
  description = "Aws Access Key Id variable from .env"
}

variable "aws_secret_access_key" {
  type        = string
  description = "Aws Secret Access Key variable from .env"
}

variable "aws_cognito_user_pool_id" {
  type        = string
  description = "Aws Cognito User Pool Id variable from .env"
}

variable "aws_cognito_app_client_id" {
  type        = string
  description = "Aws Cognito App Client Id variable from .env"
}

variable "aws_cognito_user_pool_client_id" {
  type        = string
  description = "Aws Cognito User Pool Client Id variable from .env"
}

variable "aws_cognito_app_client_secret" {
  type        = string
  description = "Aws Cognito App Client Secret variable from .env"
}
