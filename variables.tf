variable "users_by_group" {
  description = "(Required) Users Memership by azure ad groups "
  type        = map(any)
  default = {}
  nullable = false
}

variable "users_by_roles" {
  description = "(Required) Users Memership by azure ad roles "
  type        = map(any)
  default = {}
  nullable = false
}

variable "roles_by_group" {
  description = "(Required) Roles Memership by azure ad groups "
  type        = map(any)
  default = {}
  nullable = false
}
