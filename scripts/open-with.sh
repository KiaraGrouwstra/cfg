#!/usr/bin/env -S nix shell nixpkgs#xdg-utils nixpkgs#gtk3 nixpkgs#fzf --command bash
# open the given file with its only .desktop app or by whichever the user picks
# set -xe
file=$1
mime=$(xdg-mime query filetype $file)
apps=$(cat ~/.local/share/applications/mimeapps.list | grep -v 'open-with' | grep "${mime}=" | sed -E 's/.*?=//g' | sed 's/\.desktop;/\n/g' | sed 's/\.desktop//g' | sort | uniq | grep -E '.+')
count=$(echo $apps | wc -w)
if [ $count = "1" ]; then
  app=$apps
else
  app=$(echo $apps | tr " " "\n" | fzf --reverse --bind=tab:down --bind=shift-tab:up)
fi
# it won't pick up on gtk-launch otherwise somehow
nix shell nixpkgs#gtk3 --command gtk-launch $app $file
