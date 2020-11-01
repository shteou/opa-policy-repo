package main

import data.kubernetes

deny_must_have_resource_request_memory[msg] {
  container = kubernetes.containers[_]
  not container.resources.requests.memory

  msg = sprintf("%v:%v must define a resource memory request in container '%v'", [input.kind, input.metadata.name, container.name])
}


deny_must_have_resource_limit_memory[msg] {
  container = kubernetes.containers[_]
  not container.resources.limits.memory

  msg = sprintf("%v:%v must define a resource memory limit in container '%v'", [input.kind, input.metadata.name, container.name])
}


deny_must_have_resource_request_cpu[msg] {
  container = kubernetes.containers[_]
  not container.resources.requests.cpu

  msg = sprintf("%v:%v must define a resource cpu request in container '%v'", [input.kind, input.metadata.name, container.name])
}


deny_must_have_resource_limit_cpu[msg] {
  container = kubernetes.containers[_]
  not container.resources.limits.cpu

  msg = sprintf("%v:%v must define a resource cpu limit in container '%v'", [input.kind, input.metadata.name, container.name])
}

