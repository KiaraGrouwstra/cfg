#!/usr/bin/env -S nix shell nixpkgs#bash nixpkgs#nix nixpkgs#fzf nixpkgs#bubblewrap github:Mic92/nix-index-database#default --command bash

set -euo pipefail

APPS=$(nix-locate --minimal --regex '/share/applications/.*\.desktop$' \
	   | sed 's/\.out$//;/(.*)/d' \
	   | sort -u)
SELECTION=$(fzf --border \
		--reverse \
		--prompt='Demo Application: ' \
		<<< "$APPS")
# tighten the sandbox to what you need
# $HOME is tmpfs to the app so it puts its trash into a trash can
# bwrap --dev-bind / / \
#       --tmpfs "$HOME" \
      nix run nixpkgs#"$SELECTION"
