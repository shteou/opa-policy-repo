package main

import data.kubernetes

containerPort(container) {
    container.ports[i].containerPort >= 1024
}

deny_containers_have_low_ports[msg] {
  container := kubernetes.containers[_]

  not containerPort(container)

  msg = sprintf("%v:%v must not specify ports <= 1024 in container '%v'", [input.kind, input.metadata.name, container.name])
}
