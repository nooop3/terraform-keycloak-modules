variable "realm_id" {
  description = "Realm identifier hosting the Airflow Keycloak client."
  type        = string
}

variable "resource_server_id" {
  description = "ID of the Keycloak resource server (OIDC client) Airflow uses."
  type        = string
}

variable "client_id" {
  description = "ID of the Keycloak OIDC client used for creating client roles; defaults to resource_server_id."
  type        = string
  default     = null
}

variable "role_prefix" {
  description = "Prefix for created client roles (e.g. airflow -> airflow-readonly)."
  type        = string
  default     = "airflow"
}
