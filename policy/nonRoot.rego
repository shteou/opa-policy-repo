package main

import data.kubernetes

deny_pod_must_not_run_as_root[msg] {
  input.kind = "Pod"

  container := input.spec.containers[_]
  not container.securityContext.runAsNonRoot = true

  msg = sprintf("Pod:%v must not run as root", [input.metadata.name])
}

deny_podspec_must_not_run_as_root[msg] {
  kubernetes.has_pod_spec

  container := input.spec.template.spec.containers[_]
  not container.securityContext.runAsNonRoot = true

  msg = sprintf("%v:5v must not run as root", [input.kind, input.metadata.name])
}
