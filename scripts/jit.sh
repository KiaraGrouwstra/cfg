#!/usr/bin/env -S nix shell nixpkgs#bash nixpkgs#nix nixpkgs#nix-index nixpkgs#fzf github:Mic92/nix-index-database#default --command bash
# pick a program from nixpkgs and run it
# https://discourse.nixos.org/t/nixpkgs-desktop/39781/6

set -euo pipefail

APPS=$(nix-locate --minimal --regex '/share/applications/.*\.desktop$' \
	   | sed 's/\.out$//;/(.*)/d' \
	   | sort -u)
SELECTION=$(fzf --border --reverse --prompt='Demo Application: ' <<< "$APPS")
# tighten the sandbox to what you need
# $HOME is tmpfs to the app so it puts its trash into a trash can
# bwrap --dev-bind / / \
#       --tmpfs "$HOME" \
      nix run nixpkgs#"$SELECTION"
