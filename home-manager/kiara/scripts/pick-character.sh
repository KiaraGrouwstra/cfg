#!/usr/bin/env -S nix shell nixpkgs#wl-clipboard nixpkgs#gum --command sh
cat $1 | gum filter | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
