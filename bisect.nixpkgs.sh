#! /run/current-system/sw/bin/sh

NIXPKGS_COMMIT=$(git rev-parse --abbrev-ref HEAD)   # nixpkgs repo
CONFIG_COMMIT=$(cat flake.lock | jq -r '.nodes.master.locked.rev')
sed -iE "s/$CONFIG_COMMIT:/$NIXPKGS_COMMIT/g" flake.lock
NIXPKGS_HASH=$(nix-prefetch-url "https://github.com/nixos/nixpkgs/archive/refs/$(NIXPKGS_COMMIT).zip" --type sha256)
CONFIG_HASH=$(cat flake.lock | jq -r '.nodes.master.locked.narHash')
sed -iE "s/$CONFIG_HASH:/$NIXPKGS_HASH/g" flake.lock
