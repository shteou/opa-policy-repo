package main

import data.kubernetes

deny_containers_must_not_run_as_root[msg] {
  container := kubernetes.containers[_]

  not container.securityContext.runAsNonRoot

  msg = sprintf("%v:%v must not run as root in container '%v'", [input.kind, input.metadata.name, container.name])
}
