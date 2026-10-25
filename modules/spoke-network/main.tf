# ============================================================
# Module: Spoke Network
# Reusable spoke VNet with peering to Hub + UDR to Firewall
# ============================================================

resource "azurerm_resource_group" "spoke" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke-${var.spoke_name}-${var.location}"
  location            = var.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = [var.spoke_vnet_cidr]
  tags                = var.tags
}

resource "azurerm_subnet" "workload" {
  name                 = "snet-workload"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [cidrsubnet(var.spoke_vnet_cidr, 8, 0)]
}

# Route Table forcing all egress through Azure Firewall
resource "azurerm_route_table" "spoke" {
  name                          = "rt-spoke-${var.spoke_name}"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.spoke.name
  disable_bgp_route_propagation = true
  tags                          = var.tags
}

resource "azurerm_route" "default_to_firewall" {
  name                   = "udr-default-to-firewall"
  resource_group_name    = azurerm_resource_group.spoke.name
  route_table_name       = azurerm_route_table.spoke.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.firewall_private_ip
}

resource "azurerm_subnet_route_table_association" "workload" {
  subnet_id      = azurerm_subnet.workload.id
  route_table_id = azurerm_route_table.spoke.id
}

# Spoke -> Hub Peering
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = "peer-${var.spoke_name}-to-hub"
  resource_group_name          = azurerm_resource_group.spoke.name
  virtual_network_name         = azurerm_virtual_network.spoke.name
  remote_virtual_network_id    = var.hub_vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
}

# Hub -> Spoke Peering
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = "peer-hub-to-${var.spoke_name}"
  resource_group_name          = var.hub_resource_group
  virtual_network_name         = var.hub_vnet_name
  remote_virtual_network_id    = azurerm_virtual_network.spoke.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}
