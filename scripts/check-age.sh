#!/usr/bin/env -S nix shell nixpkgs#jaq nixpkgs#gum --command sh
# Check when inputs were last updated
cat flake.lock |
  jaq -r '.nodes | del(.root) | map_values(.locked.lastModified) | to_entries | sort_by(.value) | map("echo " + .key + ",\\\"$(ago " + (.value | tostring) + ")\\\"")[]' |
  sh |
  gum table -c 'input,updated' -w '25,25' --height=60
