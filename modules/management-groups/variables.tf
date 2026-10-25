variable "root_management_group_id" {
  type = string
}
variable "root_management_group_name" {
  type    = string
  default = "Enterprise Root"
}
variable "management_groups" {
  type = map(object({
    display_name               = string
    parent_management_group_id = optional(string)
  }))
  default = {}
}
variable "tags" {
  type    = map(string)
  default = {}
}
