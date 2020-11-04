package main

warn_deployment_deprecated_apiversion[msg] {
  input.kind = "Deployment"
  input.apiVersion != "apps/v1"

  msg = sprintf("Deployment '%v': expected apiVersion 'apps/v1' but found '%v'", [input.metadata.name, input.apiVersion])
}
