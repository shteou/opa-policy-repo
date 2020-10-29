package main

hasPodSpec {
    k := input.kind
    {k} & {"Deployment", "ReplicaSet", "StatefulSet", "DaemonSet"} ==  {k}
}

deny[msg] {
  input.kind = "Pod"
  value := input.spec.serviceAccountName
  value != "my-service-account"
  msg = sprintf("Pod serviceAccountName must be configurable by .Values.serviceAccount, found `%v`", [value])
}

deny[msg] {
  hasPodSpec
  kind := input.kind
  value := input.spec.template.spec.serviceAccountName
  value != "my-service-account"
  msg = sprintf("%v serviceAccountName must be configurable by .Values.serviceAccount, found `%v", [kind, value])
}

deny[msg] {
  input.kind = "ServiceAccount"
  name := input.metadata.name
  msg = sprintf("The chart should not define a ServiceAccount object, found `%v`", [name])
}
