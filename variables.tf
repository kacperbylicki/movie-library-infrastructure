variable "application_name" {
  type        = string
  description = "The name of your application"
  default     = "movie-library"
}

variable "terraform_storage_account" {
  type        = string
  description = "When using an Azure back-end, the name of the Azure Storage Account that stores the Terraform state"
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment (dev, test, prod...)"
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure region where all resources in this example should be created"
  default     = "westeurope"
}

variable "AWS_REGION" {
  type        = string
  description = "Aws Region variable from .env"
}

variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "Aws Access Key Id variable from .env"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "Aws Secret Access Key variable from .env"
}

variable "AWS_COGNITO_USER_POOL_ID" {
  type        = string
  description = "Aws Cognito User Pool Id variable from .env"
}

variable "AWS_COGNITO_APP_CLIENT_ID" {
  type        = string
  description = "Aws Cognito App Client Id variable from .env"
}

variable "AWS_COGNITO_USER_POOL_CLIENT_ID" {
  type        = string
  description = "Aws Cognito User Pool Client Id variable from .env"
}

variable "AWS_COGNITO_APP_CLIENT_SECRET" {
  type        = string
  description = "Aws Cognito App Client Secret variable from .env"
}
