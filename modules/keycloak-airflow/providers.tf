terraform {
  required_version = ">= 1.3.0"

  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = ">= 5.5.0"
    }
  }
}
