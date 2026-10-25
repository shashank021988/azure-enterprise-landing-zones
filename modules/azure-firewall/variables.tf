variable "resource_group_name"         { type = string }
variable "location"                     { type = string }
variable "firewall_subnet_id"           { type = string }
variable "firewall_management_subnet_id" { type = string }
variable "log_analytics_workspace_id"  { type = string }
variable "tls_ca_cert_secret_id" {
  type    = string
  default = ""
}
variable "tags" { type = map(string); default = {} }
