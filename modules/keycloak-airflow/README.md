# keycloak-airflow

Creates Keycloak Authorization scopes/resources and `ReadOnly`/`Admin`/`User`/`Op` permissions for an Airflow OIDC client (resource server). Also creates matching client roles `${role_prefix}-{readonly,admin,user,op}` and role policies wired to those permissions.

## Usage

```hcl
module "keycloak_airflow" {
  source = "github.com/nooop3/terraform-keycloak-modules//modules/keycloak-airflow"

  realm_id           = data.keycloak_realm.target.id
  resource_server_id = keycloak_openid_client.airflow.resource_server_id
  # role_prefix = "airflow"
}
```

Grant access by assigning the client role to users (Keycloak Admin UI: `Users` → user → `Role mapping` → `Client Roles` → select the Airflow client).

## Inputs

- `realm_id` (string, required): Realm identifier hosting the Airflow client.
- `resource_server_id` (string, required): Airflow client/resource-server UUID (OIDC client `resource_server_id`).
- `role_prefix` (string, optional): Prefix for created client roles. Default: `airflow`.

## Outputs

- `scope_ids`: Authorization scope IDs keyed by scope name.
- `resource_ids`: Standard resource IDs keyed by resource name.
- `menu_resource_ids`: Menu resource IDs keyed by menu item label.
- `permission_ids`: Authorization permission IDs keyed by permission name.
- `client_role_ids`: Client role IDs keyed by tier (`readonly/admin/user/op`).
- `role_policy_ids`: Authorization role policy IDs keyed by tier (`readonly/admin/user/op`).
