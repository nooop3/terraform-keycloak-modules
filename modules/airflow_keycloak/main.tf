terraform {
  required_version = ">= 1.3.0"

  required_providers {
    keycloak = {
      source  = "mrparkers/keycloak"
      version = ">= 5.2.0"
    }
  }
}

locals {
  scope_names = [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "MENU",
    "LIST",
  ]

  standard_scope_names = [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "LIST",
  ]

  menu_scope_names = [
    "MENU",
  ]

  keycloak_resources = [
    "Asset",
    "AssetAlias",
    "Backfill",
    "Configuration",
    "Connection",
    "Custom",
    "Dag",
    "Menu",
    "Pool",
    "Variable",
    "View",
  ]

  menu_items = [
    "Required Actions",
    "Assets",
    "Audit Log",
    "Config",
    "Connections",
    "Dags",
    "Docs",
    "Plugins",
    "Pools",
    "Providers",
    "Variables",
    "XComs",
  ]
}

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

data "keycloak_openid_client_authorization_policy" "default" {
  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = var.default_policy_name
}

locals {
  scope_ids = {
    for name, scope in keycloak_openid_client_authorization_scope.scopes :
    name => scope.id
  }

  resource_ids = {
    for name, resource in keycloak_openid_client_authorization_resource.standard :
    name => resource.id
  }
}

resource "keycloak_openid_client_authorization_permission" "read_only" {
  realm_id           = var.realm_id
  resource_server_id = var.resource_server_id
  name               = "ReadOnly"
  decision_strategy  = "UNANIMOUS"
  type               = "scope"

  policies = [data.keycloak_openid_client_authorization_policy.default.id]

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

  policies = [data.keycloak_openid_client_authorization_policy.default.id]

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

  policies = [data.keycloak_openid_client_authorization_policy.default.id]

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

  policies = [data.keycloak_openid_client_authorization_policy.default.id]

  resources = [
    local.resource_ids["Connection"],
    local.resource_ids["Pool"],
    local.resource_ids["Variable"],
    local.resource_ids["Backfill"],
  ]
}
