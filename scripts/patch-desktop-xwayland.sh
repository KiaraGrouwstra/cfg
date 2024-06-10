#!/usr/bin/env -S nix shell nixpkgs#gnused --command sh
# patch persisted wine/steam desktop entries to run xwayland
cd "/persist$HOME/.local/share/applications/" &&
  find . -name "*.desktop" | while read -r line; do
    file=$(echo $line | sed "s/'//g")
    desktop=$(cat "$file")
    if echo "$desktop" | grep -q '^Exec=(wine|steam)'; then
      echo "$desktop" | sed -E "s/^Exec=(.*)\$/Exec=xwayland-run -- \\1/g" >"$file"
    fi
  done
