#!/usr/bin/env sh
# dunno how to query present wallpaper in swaybg, so get a random one
find ~/Pictures/wallpapers/ \
  | sort -R \
  | tail -n 1 \
  | while read -r img ; do \
  	  swaylock -i $img;
  	done
