package main

import data.kubernetes

deny_pod_has_no_service_account_name[msg] {
  input.kind = "Pod"

  input.spec.serviceAccountName != "my-service-account"

  msg = sprintf("Pod serviceAccountName must be configurable by .Values.serviceAccount, found `%v`", [input.spec.serviceAccountName])
}

exception[rules] {
  input.kind != "Pod"
  rules = ["pod_has_no_service_account_name"]
}

deny_deployment_has_no_service_account_name[msg] {
  kubernetes.hasPodSpec

  input.spec.template.spec.serviceAccountName != "my-service-account"

  msg = sprintf("%v serviceAccountName must be configurable by .Values.serviceAccount, found `%v", [input.kind, input.spec.template.spec.serviceAccountName])
}

exception[rules] {
  not kubernetes.hasPodSpec
  rules = ["deployment_has_no_service_account_name"]
}

deny_has_service_account[msg] {
  input.kind = "ServiceAccount"

  msg = sprintf("The chart should not define a ServiceAccount object, found `%v`", [input.metadata.name])
}

exception[rules] {
  input.kind != "ServiceAccount"
  rules = ["has_service_account"]
}

