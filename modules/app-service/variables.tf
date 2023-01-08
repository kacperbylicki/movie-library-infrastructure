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

variable "azure_application_insights_instrumentation_key" {
  type        = string
  description = "The Azure Application Insights instrumentation key"
}

variable "vault_id" {
  type        = string
  description = "The Azure Key Vault ID"
}

variable "azure_cosmosdb_mongodb_database" {
  type        = string
  description = "The Cosmos DB with MongoDB API database name"
  default     = "MovieLibrary"
}

variable "azure_cosmosdb_mongodb_uri" {
  type        = string
  description = "The Cosmos DB with MongoDB API database URI"
}

variable "azure_cosmosdb_mongodb_database_movies_collection" {
  type        = string
  description = "The Cosmos DB with MongoDB API database movies collection"
  default     = "Movies"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "eu-central-1"
}

variable "aws_access_key_id" {
  type        = string
  description = "AWS Access Key Id"
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS Secret Access Key"
}

variable "aws_cognito_user_pool_id" {
  type        = string
  description = "AWS Cognito User Pool Id"
}

variable "aws_cognito_app_client_id" {
  type        = string
  description = "AWS Cognito App Client Id"
}

variable "aws_cognito_user_pool_client_id" {
  type        = string
  description = "AWS Cognito User Pool Client Id"
}

variable "aws_cognito_app_client_secret" {
  type        = string
  description = "AWS Cognito App Client Secret"
}

variable "port" {
  type        = string
  description = ""
  default     = "8080"
}