# terraform-airflow-modules

Terraform bits for Airflow. Right now it only syncs the Keycloak Authorization objects the Airflow Keycloak auth manager expects.

## airflow_keycloak

Creates scopes (`GET`, `POST`, `PUT`, `DELETE`, `MENU`, `LIST`), the Keycloak resources/menu items tied to those scopes, plus the `ReadOnly`, `Admin`, `User`, and `Op` permissions.

```hcl
module "airflow_keycloak" {
  source = "github.com/nooop3/terraform-airflow-modules//modules/airflow_keycloak"

  realm_id           = data.keycloak_realm.target.id
  resource_server_id = keycloak_openid_client.airflow.resource_server_id
  # default_policy_name = "Default Policy"
}
```

Outputs expose the scope/resource/permission IDs for wiring other stacks.
