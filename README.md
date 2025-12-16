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
  # Optional: override client UUID for client role creation.
  # client_id = keycloak_openid_client.airflow.id

  # Creates client roles like airflow-readonly/admin/user/op.
  # role_prefix = "airflow"
}
```

Outputs expose the scope/resource/permission IDs for wiring other stacks.
