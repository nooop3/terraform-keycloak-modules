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
