#!/usr/bin/env -S nix shell nixpkgs#unar --command sh
# unarchive an archive file
file="$1"
dir=$(dirname "$(readlink -f "$file")")
dest=$(unar -f -o "$dir" "$file" | grep -Eo '"(.*)"' | sed 's/"//g')
xdg-open "$dest"
