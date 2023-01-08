terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.22"
    }
  }
}

resource "azurecaf_name" "static-site" {
  name          = var.application_name
  resource_type = "azurerm_static_site"
  suffixes      = [var.environment]
}

resource "azurerm_static_site" "application" {
  name = azurecaf_name.static-site.result
  resource_group_name = var.resource_group
  location = var.location
}