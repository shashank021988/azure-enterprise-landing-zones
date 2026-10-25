variable "root_management_group_id" {
  description = "ID of the root Azure Management Group"
  type        = string
}

variable "root_management_group_name" {
  description = "Display name for the root management group"
  type        = string
  default     = "Enterprise Root"
}

variable "management_groups" {
  description = "Map of management groups to create under root"
  type = map(object({
    display_name               = string
    parent_management_group_id = optional(string)
  }))
  default = {}
}

variable "hub_resource_group_name" {
  description = "Resource group for hub networking resources"
  type        = string
}

variable "primary_location" {
  description = "Primary Azure region for deployment"
  type        = string
  default     = "eastus2"
}

variable "hub_vnet_cidr" {
  description = "CIDR block for the hub VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "gateway_subnet_cidr" {
  description = "CIDR for GatewaySubnet (ExpressRoute/VPN)"
  type        = string
  default     = "10.0.0.0/27"
}

variable "firewall_subnet_cidr" {
  description = "CIDR for AzureFirewallSubnet"
  type        = string
  default     = "10.0.1.0/26"
}

variable "bastion_subnet_cidr" {
  description = "CIDR for AzureBastionSubnet"
  type        = string
  default     = "10.0.2.0/27"
}

variable "spoke_corp_cidr" {
  description = "CIDR for Corp spoke VNet"
  type        = string
  default     = "10.10.0.0/16"
}

variable "spoke_online_cidr" {
  description = "CIDR for Online spoke VNet"
  type        = string
  default     = "10.20.0.0/16"
}

variable "environment" {
  description = "Deployment environment (prod, staging, dev)"
  type        = string
  validation {
    condition     = contains(["prod", "staging", "dev"], var.environment)
    error_message = "Environment must be prod, staging, or dev."
  }
}

variable "default_tags" {
  description = "Tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy   = "Terraform"
    Framework   = "CAF-LandingZones"
    CostCenter  = "Platform"
  }
}
