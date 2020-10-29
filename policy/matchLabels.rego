package main

import data.kubernetes

warn_no_match_appname_label[msg] {
  kubernetes.has_pod_spec

  labels := input.spec.selector.matchLabels
  object.get(labels, "app.kubernetes.io/name", "") == ""

  msg = sprintf("%v:%v should provide app.kubernetes.io/name label in pod selectors", [input.kind, input.metadata.name])
}
