package kubernetes

hasPodSpec {
    k := input.kind
    {k} & {"Deployment", "ReplicaSet", "StatefulSet", "DaemonSet"} ==  {k}
}
