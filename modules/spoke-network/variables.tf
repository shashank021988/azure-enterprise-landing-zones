variable "spoke_name"          { type = string }
variable "resource_group_name" { type = string }
variable "location"            { type = string }
variable "spoke_vnet_cidr"     { type = string }
variable "hub_vnet_id"         { type = string }
variable "hub_vnet_name"       { type = string }
variable "hub_resource_group"  { type = string }
variable "firewall_private_ip" { type = string }
variable "tags"                { type = map(string); default = {} }
