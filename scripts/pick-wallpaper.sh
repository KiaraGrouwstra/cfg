#!/usr/bin/env -S nix shell nixpkgs#fzf nixpkgs#swaybg nixpkgs#wallust --command bash
# pick a wallpaper and set it
export wallpaper_dir=~/Pictures/wallpapers/
ls $wallpaper_dir | fzf --reverse --preview 'pistol {}' | while read -r img; do
  pidof swaybg && kill -9 $(pidof swaybg)
  swaybg -m fill -o '*' -i $wallpaper_dir$img
  wallust run $wallpaper_dir$img
done
