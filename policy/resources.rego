package main

import data.kubernetes

deny_pod_must_have_resources[msg] {
  input.kind = "Pod"

  container := input.spec.containers[_]
  container.resources.requests.memory == ""
  container.resources.requests.cpu == ""
  container.resources.limits.memory == ""
  container.resources.limits.cpu == ""

  msg = sprintf("Pod:%v must define resources", [input.metadata.name])
}

deny_podspec_must_have_resources[msg] {
  kubernetes.has_pod_spec

  container := input.spec.template.spec.containers[_]
  trace(container.name)
  container.resources.requests.memory == ""
  container.resources.requests.cpu == ""
  container.resources.limits.memory == ""
  container.resources.limits.cpu == ""

  msg = sprintf("%v:%v must define podSpec resources", [input.kind, input.metadata.name])
}
