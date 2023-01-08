output "static_web_app_api_key" {
  value = azurerm_static_site.application.api_key
  sensitive = true
}