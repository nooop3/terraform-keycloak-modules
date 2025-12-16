output "scope_ids" {
  description = "Authorization scope IDs keyed by scope name."
  value = {
    for name, scope in keycloak_openid_client_authorization_scope.scopes :
    name => scope.id
  }
}

output "resource_ids" {
  description = "Standard resource IDs keyed by the Keycloak resource name."
  value = {
    for name, resource in keycloak_openid_client_authorization_resource.standard :
    name => resource.id
  }
}

output "menu_resource_ids" {
  description = "Menu resource IDs keyed by menu item label."
  value = {
    for name, resource in keycloak_openid_client_authorization_resource.menu :
    name => resource.id
  }
}

output "permission_ids" {
  description = "Authorization permission IDs keyed by permission name."
  value = {
    ReadOnly = keycloak_openid_client_authorization_permission.read_only.id
    Admin    = keycloak_openid_client_authorization_permission.admin.id
    User     = keycloak_openid_client_authorization_permission.user.id
    Op       = keycloak_openid_client_authorization_permission.op.id
  }
}

output "client_role_ids" {
  description = "Client role IDs keyed by tier (readonly/admin/user/op)."
  value = {
    for name, role in keycloak_role.client_roles :
    name => role.id
  }
}
