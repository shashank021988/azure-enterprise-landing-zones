# ============================================================
# Module: Management Groups
# Creates the enterprise management group hierarchy
# ============================================================

resource "azurerm_management_group" "root" {
  display_name = var.root_management_group_name
}

resource "azurerm_management_group" "platform" {
  display_name               = "Platform"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "connectivity" {
  display_name               = "Connectivity"
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "identity" {
  display_name               = "Identity"
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "management" {
  display_name               = "Management"
  parent_management_group_id = azurerm_management_group.platform.id
}

resource "azurerm_management_group" "landing_zones" {
  display_name               = "Landing Zones"
  parent_management_group_id = azurerm_management_group.root.id
}

resource "azurerm_management_group" "corp" {
  display_name               = "Corp"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

resource "azurerm_management_group" "online" {
  display_name               = "Online"
  parent_management_group_id = azurerm_management_group.landing_zones.id
}

# CIS Policy Initiative Assignment
resource "azurerm_management_group_policy_assignment" "cis_benchmark" {
  name                 = "cis-azure-benchmark-v2"
  management_group_id  = azurerm_management_group.root.id
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/06f19060-9e68-4070-92ca-f15cc126059e"
  display_name         = "CIS Microsoft Azure Foundations Benchmark v2.0.0"
  description          = "Enforces CIS Azure Benchmark compliance across all management groups"
  enforce              = true
}
