#!/usr/bin/env -S nix shell nixpkgs#wl-clipboard nixpkgs#fzf --command sh
cat $1 | fzf | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
