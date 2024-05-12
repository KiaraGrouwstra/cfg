#!/usr/bin/env -S nix shell nixpkgs#unar --command sh
# unarchive an archive file
file="$1"
dir=$(unar -f "$file" | grep -Eo '"(.*)"' | sed 's/"//g')
xdg-open "$dir"
