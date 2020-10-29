package main

deny_must_not_run_as_root[msg] {
  input.kind = "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.runAsNonRoot = true
  msg = "Containers must not run as root"
}
