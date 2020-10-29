package main

warn_no_match_appname_label[msg] {
  input.kind = "Deployment"
  labels := input.spec.selector.matchLabels
  object.get(labels, "app.kubernetes.io/name", "") == ""
  msg = "Containers must provide app label for pod selectors"
}
