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
  # default_policy_name = "Default Policy"
}
```

Outputs expose the scope/resource/permission IDs for wiring other stacks.
