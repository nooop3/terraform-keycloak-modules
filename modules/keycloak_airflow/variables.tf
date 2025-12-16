variable "realm_id" {
  description = "Realm identifier hosting the Airflow Keycloak client."
  type        = string
}

variable "resource_server_id" {
  description = "ID of the Keycloak resource server (OIDC client) Airflow uses."
  type        = string
}

variable "default_policy_name" {
  description = "Authorization policy attached to the Airflow client; defaults to the Keycloak generated one."
  type        = string
  default     = "Default Policy"
}
