output "management_group_ids" {
  value = {
    root         = azurerm_management_group.root.id
    platform     = azurerm_management_group.platform.id
    connectivity = azurerm_management_group.connectivity.id
    identity     = azurerm_management_group.identity.id
    management   = azurerm_management_group.management.id
    landing_zones = azurerm_management_group.landing_zones.id
    corp         = azurerm_management_group.corp.id
    online       = azurerm_management_group.online.id
  }
}
