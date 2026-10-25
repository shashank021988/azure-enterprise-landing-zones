# ============================================================
# Module: Azure Firewall Premium
# TLS inspection, IDPS, URL filtering
# ============================================================

resource "azurerm_public_ip" "firewall" {
  name                = "pip-azfw-hub"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags                = var.tags
}

resource "azurerm_public_ip" "firewall_mgmt" {
  name                = "pip-azfw-mgmt-hub"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
  tags                = var.tags
}

resource "azurerm_firewall_policy" "main" {
  name                     = "afwp-hub-premium"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Premium"
  threat_intelligence_mode = "Alert"

  intrusion_detection {
    mode = "Alert"
  }

  tls_certificate {
    key_vault_secret_id = var.tls_ca_cert_secret_id
    name                = "TLS-CA-Certificate"
  }

  insights {
    enabled                            = true
    default_log_analytics_workspace_id = var.log_analytics_workspace_id
    retention_in_days                  = 30
  }

  tags = var.tags
}

resource "azurerm_firewall" "main" {
  name                = "azfw-hub-premium"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Premium"
  firewall_policy_id  = azurerm_firewall_policy.main.id
  zones               = ["1", "2", "3"]

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }

  management_ip_configuration {
    name                 = "management"
    subnet_id            = var.firewall_management_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_mgmt.id
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "firewall" {
  name                       = "diag-azfw-hub"
  target_resource_id         = azurerm_firewall.main.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log { category = "AzureFirewallApplicationRule" }
  enabled_log { category = "AzureFirewallNetworkRule" }
  enabled_log { category = "AzureFirewallDnsProxy" }
  enabled_log { category = "AzureFirewallThreatIntel" }
  metric { category = "AllMetrics" }
}
