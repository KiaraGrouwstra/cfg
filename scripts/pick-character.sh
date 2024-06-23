#!/usr/bin/env -S nix shell nixpkgs#wl-clipboard nixpkgs#fzf --command sh
# pick a character and copy it
cat $1 | fzf --reverse | cut -d ' ' -f 1 | tr -d '\n' | wl-copy
