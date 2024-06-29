#!/usr/bin/env -S nix shell nixpkgs#curl nixpkgs#xdg-utils nixpkgs#rqbit --command sh
file=$1
if [[ $file == http* || $file == magnet* ]]; then
  # remote torrent or magnet
  rqbit download -o ~/Downloads "$file" || curl -d "$file" http://127.0.0.1:3029/torrents && xdg-open http://127.0.0.1:3029/web/
else
  # local torrent
  rqbit download -o ~/Downloads "$file" || curl --data-binary "@$file" http://127.0.0.1:3029/torrents && xdg-open http://127.0.0.1:3029/web/
fi
