# ============================================================
# Root Orchestration - Azure Enterprise Landing Zones
# ============================================================

module "management_groups" {
  source = "./modules/management-groups"

  root_management_group_id   = var.root_management_group_id
  root_management_group_name = var.root_management_group_name
  management_groups          = var.management_groups
  tags                       = var.default_tags
}

module "hub_network" {
  source = "./modules/hub-network"

  depends_on = [module.management_groups]

  resource_group_name = var.hub_resource_group_name
  location            = var.primary_location
  hub_vnet_cidr       = var.hub_vnet_cidr
  gateway_subnet_cidr = var.gateway_subnet_cidr
  firewall_subnet_cidr = var.firewall_subnet_cidr
  bastion_subnet_cidr = var.bastion_subnet_cidr
  tags                = var.default_tags
}

module "azure_firewall" {
  source = "./modules/azure-firewall"

  depends_on = [module.hub_network]

  resource_group_name         = var.hub_resource_group_name
  location                    = var.primary_location
  firewall_subnet_id          = module.hub_network.firewall_subnet_id
  firewall_management_subnet_id = module.hub_network.firewall_mgmt_subnet_id
  log_analytics_workspace_id  = module.hub_network.log_analytics_workspace_id
  tags                        = var.default_tags
}

module "spoke_corp" {
  source = "./modules/spoke-network"

  depends_on = [module.hub_network]

  spoke_name          = "corp"
  resource_group_name = "rg-spoke-corp-${var.environment}"
  location            = var.primary_location
  spoke_vnet_cidr     = var.spoke_corp_cidr
  hub_vnet_id         = module.hub_network.hub_vnet_id
  hub_vnet_name       = module.hub_network.hub_vnet_name
  hub_resource_group  = var.hub_resource_group_name
  firewall_private_ip = module.azure_firewall.firewall_private_ip
  tags                = var.default_tags
}

module "spoke_online" {
  source = "./modules/spoke-network"

  depends_on = [module.hub_network]

  spoke_name          = "online"
  resource_group_name = "rg-spoke-online-${var.environment}"
  location            = var.primary_location
  spoke_vnet_cidr     = var.spoke_online_cidr
  hub_vnet_id         = module.hub_network.hub_vnet_id
  hub_vnet_name       = module.hub_network.hub_vnet_name
  hub_resource_group  = var.hub_resource_group_name
  firewall_private_ip = module.azure_firewall.firewall_private_ip
  tags                = var.default_tags
}
