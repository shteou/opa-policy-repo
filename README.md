# helm OPA policies

This repository contains a series of OPA policies for applying to Helm charts.

It implements the following rules:

 - Deny all containers running as root
 - Deny all Deployments / ReplicaSets / StatefulSets (hereafter referred to as Deployments) without an appropriate labelSelector
 - Deny all pods whose serviceAccount cannot be overridden
 - Deny all ServiceAccount types
