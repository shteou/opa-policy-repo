package main



warn[msg] {
  input.kind = "Deployment"
  container := input.spec.template.spec.containers[_]
  not container.securityContext.runAsNonRoot = true
  msg = "Containers must not run as root"
}

deny[msg] {
  input.kind = "Deployment"
  not input.spec.selector.matchLabels.app
  msg = "Containers must provide app label for pod selectors"
}
