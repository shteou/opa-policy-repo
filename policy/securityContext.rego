package main

import data.kubernetes

warn_containers_must_not_run_as_root[msg] {
  container := kubernetes.containers[_]

  not container.securityContext.runAsNonRoot

  msg = sprintf("%v:%v must not run as root in container '%v'", [input.kind, input.metadata.name, container.name])
}

warn_containers_allowing_privilege_escalation[msg] {
  container := kubernetes.containers[_]

  not container.securityContext.allowPrivilegeEscalation == false

  msg = sprintf("%v:%v must not allow privilege escalation in '%v'", [input.kind, input.metadata.name, container.name])
}
