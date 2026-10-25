output "hub_vnet_id"              { value = azurerm_virtual_network.hub.id }
output "hub_vnet_name"            { value = azurerm_virtual_network.hub.name }
output "firewall_subnet_id"       { value = azurerm_subnet.firewall.id }
output "firewall_mgmt_subnet_id"  { value = azurerm_subnet.firewall_mgmt.id }
output "gateway_subnet_id"        { value = azurerm_subnet.gateway.id }
output "bastion_subnet_id"        { value = azurerm_subnet.bastion.id }
output "log_analytics_workspace_id" { value = azurerm_log_analytics_workspace.hub.id }
