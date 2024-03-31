#!/usr/bin/env -S nix shell nixpkgs#unar --command sh
# unarchive an archive file
file="$1"

# https://superuser.com/a/1526751/155548
base="$(dirname $file)/$(
  b=${file##*/}
  echo ${b%.*}
)"

unar -f "$file" &&
  xdg-open "$base"
