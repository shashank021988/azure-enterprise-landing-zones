output "hub_vnet_id" {
  description = "Resource ID of the Hub VNet"
  value       = module.hub_network.hub_vnet_id
}

output "hub_vnet_name" {
  description = "Name of the Hub VNet"
  value       = module.hub_network.hub_vnet_name
}

output "firewall_private_ip" {
  description = "Private IP of Azure Firewall (used as next-hop for UDRs)"
  value       = module.azure_firewall.firewall_private_ip
}

output "spoke_corp_vnet_id" {
  description = "Resource ID of Corp Spoke VNet"
  value       = module.spoke_corp.spoke_vnet_id
}

output "spoke_online_vnet_id" {
  description = "Resource ID of Online Spoke VNet"
  value       = module.spoke_online.spoke_vnet_id
}

output "management_group_ids" {
  description = "Map of management group IDs"
  value       = module.management_groups.management_group_ids
}
