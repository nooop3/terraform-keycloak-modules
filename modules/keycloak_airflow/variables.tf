variable "realm_id" {
  description = "Realm identifier hosting the Airflow Keycloak client."
  type        = string
}

variable "resource_server_id" {
  description = "ID (UUID) of the Keycloak OIDC client / resource server Airflow uses."
  type        = string
}

variable "role_prefix" {
  description = "Prefix for created client roles (e.g. airflow -> airflow-readonly)."
  type        = string
  default     = "airflow"
}
