# get users ids from mails
data "azuread_user" "main" {
  for_each            = { for k, v in local.groups_users : join("-", ["object_id", tostring(k)]) => v }
  user_principal_name = each.value.user
}

data "azuread_groups" "all" {
  display_names = keys(var.users_by_group)
}


data "azurerm_role_definition" "users_by_roles_ids" {
    for_each =  toset(keys(var.users_by_roles)) 
    name = each.value
}


data "azurerm_subscription" "primary" {
}