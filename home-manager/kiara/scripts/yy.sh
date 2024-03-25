#!/usr/bin/env -S nix shell nixpkgs#yazi --command bash
# yazi wrapper to set shell directory on exit
# https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
tmp="$(mktemp -t "yazi-cwd.XXXXX")"
yazi "$@" --cwd-file="$tmp"
if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
fi
rm -f -- "$tmp"
$SHELL
