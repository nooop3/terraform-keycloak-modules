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

variable "default_policy_name" {
  description = "Authorization policy attached to the Airflow client; defaults to the Keycloak generated one."
  type        = string
  default     = "Default Policy"
}

variable "role_prefix" {
  description = "Prefix for created realm roles (e.g. airflow -> airflow-readonly)."
  type        = string
  default     = "airflow"
}
