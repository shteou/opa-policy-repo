package main

# An example rule which denies ingress hosts with an incorrect suffix
# This could be parameterised with data to make applicable to different
# environments
deny_invalid_hostname_suffix[msg] {
  input.kind = "Ingress"

  some i
  not endswith(input.spec.rules[i].host, "staging.example.com")

  msg = sprintf("Found an invalid hostname, '%v', in ingress '%v'", [input.spec.rules[i].host, input.metadata.name])
}

