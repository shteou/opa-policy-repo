package main

has_revision_history_limit {
        k := input.kind
        {k} & {"Deployment", "StatefulSet", "DaemonSet"} == {k}
}

valid_revision_history_limit {
    input.spec.revisionHistoryLimit
    input.spec.revisionHistoryLimit >= 5
}

warn_replicaset_no_explicit_revision_history_limit[msg] {
    has_revision_history_limit

    not valid_revision_history_limit

    msg = sprintf("%v:%v must specify a revision history limit >= 5", [input.kind, input.metadata.name])
}
