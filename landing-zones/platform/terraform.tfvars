root_management_group_id   = "your-root-mg-id"
root_management_group_name = "Enterprise Root"
hub_resource_group_name    = "rg-hub-connectivity-prod"
primary_location           = "eastus2"
environment                = "prod"
hub_vnet_cidr              = "10.0.0.0/16"
gateway_subnet_cidr        = "10.0.0.0/27"
firewall_subnet_cidr       = "10.0.1.0/26"
bastion_subnet_cidr        = "10.0.2.0/27"
spoke_corp_cidr            = "10.10.0.0/16"
spoke_online_cidr          = "10.20.0.0/16"

default_tags = {
  ManagedBy   = "Terraform"
  Framework   = "CAF-LandingZones"
  Environment = "Production"
  CostCenter  = "Platform-Engineering"
  Owner       = "DevSecOps-Team"
}
