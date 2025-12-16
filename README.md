# terraform-keycloak-modules

Terraform modules for managing Keycloak configuration.

## Modules

### keycloak_airflow

Creates scopes (`GET`, `POST`, `PUT`, `DELETE`, `MENU`, `LIST`), resources/menu items, and the `ReadOnly`, `Admin`, `User`, and `Op` permissions expected by Airflow's Keycloak auth manager.

```hcl
module "keycloak_airflow" {
  source = "github.com/nooop3/terraform-keycloak-modules//modules/keycloak_airflow"

  realm_id           = data.keycloak_realm.target.id
  resource_server_id = keycloak_openid_client.airflow.resource_server_id

  # Creates client roles like airflow-readonly/admin/user/op.
  # role_prefix = "airflow"
}
```

Authorization permissions are wired to role policies for those client roles; grant access by assigning the client role to users (Keycloak Admin UI: `Users` → user → `Role mapping` → `Client Roles` → select the Airflow client).

Outputs expose IDs for wiring other stacks.
