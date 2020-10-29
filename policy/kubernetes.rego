package kubernetes

has_pod_spec {
    k := input.kind
    {k} & {"Deployment", "ReplicaSet", "StatefulSet", "DaemonSet"} ==  {k}
}
