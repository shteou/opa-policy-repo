package main

hasPodSpec {
    k := input.kind
    {k} & {"Deployment", "ReplicaSet", "StatefulSet", "DaemonSet"} ==  {k}
}

deny_pod_has_no_service_account_name[msg] {
  input.kind = "Pod"
  value := input.spec.serviceAccountName
  value != "my-service-account"
  msg = sprintf("Pod serviceAccountName must be configurable by .Values.serviceAccount, found `%v`", [value])
}

exception[rules] {
  input.kind != "Pod"
  rules = ["pod_has_no_service_account_name"]
}

deny_deployment_has_no_service_account_name[msg] {
  hasPodSpec
  kind := input.kind
  value := input.spec.template.spec.serviceAccountName
  value != "my-service-account"
  msg = sprintf("%v serviceAccountName must be configurable by .Values.serviceAccount, found `%v", [kind, value])
}

exception[rules] {
  not hasPodSpec
  rules = ["deployment_has_no_service_account_name"]
}

deny_has_service_account[msg] {
  input.kind = "ServiceAccount"
  name := input.metadata.name
  msg = sprintf("The chart should not define a ServiceAccount object, found `%v`", [name])
}

exception[rules] {
  input.kind != "ServiceAccount"
  rules = ["has_service_account"]
}

