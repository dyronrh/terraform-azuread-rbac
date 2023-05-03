
locals {
groups_users = flatten([
    for  group, users in var.users_by_group: [
      for k, v in users : {
        group = group
        user  = v
      }
    ]
  ])

users_roles = flatten([
    for  role, users in var.users_by_roles: [
      for k, v in users : {
        role = role
        user  = v
      }
    ]
  ])

groups_roles = flatten([
    for  group, roles in var.roles_by_group: [
      for k, v in roles : {
        group = group
        role  = v
      }
    ]
  ])

users_ids = flatten([
    for  key, users in data.azuread_user.main: [
      for k, v in users :  {
        user_id = v
      } if k == "id"
    ]
  ])
// roles_ids = flatten([
//     for  key, users in data.azurerm_role_definition.users_by_roles_ids: [
//       for k, v in users :  {
//         role_id = v
//       }
//     ]
//   ])

  users_groups_ids =  {for group, user in  local.groups_users: group => merge(user,{id = values(local.users_ids[tonumber(group)])[0]})} 
  #roles_groups_ids =  {for group, roles in local.groups_roles: group => merge(role,{id = })} 
}

#binding users and groups
resource "azuread_group_member" "main" {
for_each = local.users_groups_ids
  group_object_id  = data.azuread_groups.all.object_ids[index(data.azuread_groups.all.display_names,each.value.group)] 
  member_object_id = each.value.id
}

#binding roles and groups
// resource "azurerm_role_assignment" "example" {
//   for_each           = data.azuread_user.user
//   scope              = data.azurerm_subscription.primary.id
//   role_definition_id = azurerm_role_definition.support_dash_read.id
//   principal_id       = data.azuread_user.user[each.key].object_id
// }

