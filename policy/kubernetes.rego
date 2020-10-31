package kubernetes

has_pod_spec {
    k := input.kind
    {k} & {"Deployment", "ReplicaSet", "StatefulSet", "DaemonSet"} ==  {k}
}

pods[pod] {
        input.kind = "Pod"
        pod = input
}

pods[pod] {
        has_pod_spec
        pod = input.spec.template
}

pod_containers(pod) = all_containers {
        keys = {"containers", "initContainers"}
        all_containers = [c | keys[k]; c = pod.spec[k][_]]
}

containers[container] {
        pods[pod]
        all_containers = pod_containers(pod)
        container = all_containers[_]
}

containers[container] {
        all_containers = pod_containers(input)
        container = all_containers[_]
}
