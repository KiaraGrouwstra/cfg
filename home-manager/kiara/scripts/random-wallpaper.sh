#!/usr/bin/env sh
# set a random wallpaper
pidof swaybg && kill -9 $(pidof swaybg)
find ~/Pictures/wallpapers/ \
  | sort -R \
  | tail -n 1 \
  | while read -r img ; do \
  	  swaybg -m fill -o '*' -i $img;
  	  wallust run $img;
  	done
