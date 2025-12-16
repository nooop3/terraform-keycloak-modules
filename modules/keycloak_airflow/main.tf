resource "keycloak_openid_client_authorization_scope" "scopes" {
  for_each = toset(local.scope_names)

  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = each.key
  display_name       = each.key
}

resource "keycloak_openid_client_authorization_resource" "standard" {
  for_each = toset(local.keycloak_resources)

  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = each.key
  display_name       = each.key
  scopes = [
    for scope_name in local.standard_scope_names :
    keycloak_openid_client_authorization_scope.scopes[scope_name].name
  ]
}

resource "keycloak_openid_client_authorization_resource" "menu" {
  for_each = toset(local.menu_items)

  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = each.key
  display_name       = each.key
  scopes = [
    for scope_name in local.menu_scope_names :
    keycloak_openid_client_authorization_scope.scopes[scope_name].name
  ]
}

locals {
  effective_client_id = coalesce(var.client_id, var.resource_server_id)

  scope_ids = {
    for name, scope in keycloak_openid_client_authorization_scope.scopes :
    name => scope.id
  }

  resource_ids = {
    for name, resource in keycloak_openid_client_authorization_resource.standard :
    name => resource.id
  }
}

resource "keycloak_role" "client_roles" {
  for_each = local.client_roles

  realm_id  = var.realm_id
  client_id = local.effective_client_id
  name      = each.value

  description = "Airflow access tier client role managed by terraform-keycloak-modules."
}

resource "keycloak_openid_client_role_policy" "tiers" {
  for_each = local.client_roles

  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = "${each.value}-policy"
  description        = "Grants access when user has client role '${each.value}'."
  decision_strategy  = "UNANIMOUS"
  logic              = "POSITIVE"
  type               = "role"

  role {
    id       = keycloak_role.client_roles[each.key].id
    required = true
  }
}

resource "keycloak_openid_client_authorization_permission" "read_only" {
  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = "ReadOnly"
  decision_strategy  = "UNANIMOUS"
  type               = "scope"

  policies = [keycloak_openid_client_role_policy.tiers["readonly"].id]

  scopes = [
    local.scope_ids["GET"],
    local.scope_ids["MENU"],
    local.scope_ids["LIST"],
  ]
}

resource "keycloak_openid_client_authorization_permission" "admin" {
  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = "Admin"
  decision_strategy  = "UNANIMOUS"
  type               = "scope"

  policies = [keycloak_openid_client_role_policy.tiers["admin"].id]

  scopes = [
    local.scope_ids["GET"],
    local.scope_ids["POST"],
    local.scope_ids["PUT"],
    local.scope_ids["DELETE"],
    local.scope_ids["MENU"],
    local.scope_ids["LIST"],
  ]
}

resource "keycloak_openid_client_authorization_permission" "user" {
  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = "User"
  decision_strategy  = "UNANIMOUS"
  type               = "resource"

  policies = [keycloak_openid_client_role_policy.tiers["user"].id]

  resources = [
    local.resource_ids["Dag"],
    local.resource_ids["Asset"],
  ]
}

resource "keycloak_openid_client_authorization_permission" "op" {
  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = "Op"
  decision_strategy  = "UNANIMOUS"
  type               = "resource"

  policies = [keycloak_openid_client_role_policy.tiers["op"].id]

  resources = [
    local.resource_ids["Connection"],
    local.resource_ids["Pool"],
    local.resource_ids["Variable"],
    local.resource_ids["Backfill"],
  ]
}
