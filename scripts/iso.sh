#!/usr/bin/env sh
# unarchive an iso file
file="$1"
name=$(basename "$file" .iso)
dest="/media/$name"
sudo mkdir -p "$dest" && sudo mount -o loop "$file" "$dest" && xdg-open "$dest"
