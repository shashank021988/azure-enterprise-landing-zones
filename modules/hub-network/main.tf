# ============================================================
# Module: Hub Network
# Hub VNet with Firewall, Gateway, Bastion subnets
# ============================================================

resource "azurerm_resource_group" "hub" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = [var.hub_vnet_cidr]
  dns_servers         = ["168.63.129.16"]
  tags                = var.tags
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.gateway_subnet_cidr]
}

resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.firewall_subnet_cidr]
}

resource "azurerm_subnet" "firewall_mgmt" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.firewall_mgmt_subnet_cidr]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.bastion_subnet_cidr]
}

resource "azurerm_log_analytics_workspace" "hub" {
  name                = "law-hub-platform"
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
  retention_in_days   = 90
  tags                = var.tags
}
