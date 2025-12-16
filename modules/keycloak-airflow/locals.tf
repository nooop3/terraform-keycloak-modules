locals {
  # https://github.com/apache/airflow/blob/main/providers/keycloak/src/airflow/providers/keycloak/auth_manager/cli/commands.py#L123
  scope_names = [
    "GET",
    "POST",
    "PUT",
    "DELETE",
    "MENU",
    "LIST",
  ]

  # https://github.com/apache/airflow/blob/main/airflow-core/src/airflow/api_fastapi/auth/managers/base_auth_manager.py#L76
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

  # https://github.com/apache/airflow/blob/main/providers/keycloak/src/airflow/providers/keycloak/auth_manager/resources.py#L22
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

  # https://github.com/apache/airflow/blob/bef558dfb20104683fc76f86ba78c7851c405947/airflow-core/src/airflow/api_fastapi/common/types.py#L92
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

  client_roles = {
    readonly = "${var.role_prefix}-readonly"
    admin    = "${var.role_prefix}-admin"
    user     = "${var.role_prefix}-user"
    op       = "${var.role_prefix}-op"
  }
}
