#!/usr/bin/env -S nix shell nixpkgs#wezterm nixpkgs#yazi nixpkgs#lazygit nixpkgs#just nixpkgs#jaq --command bash
# wezterm cli spawn --cwd / --new-window -- yazi --cwd-file /dev/stdout | while read -r dir; do; done
# export dir=$(yazi --cwd-file /dev/stdout)
export dir=$PWD
# export pane_id=$(wezterm cli spawn --cwd $dir --new-window -- lazygit)
export pane_id=$WEZTERM_PANE
export window_id=$(wezterm cli list --format json | jaq "map(select(.pane_id == $pane_id)) | .[].window_id")
wezterm cli spawn --window-id $window_id --cwd $dir -- lazygit
wezterm cli spawn --window-id $window_id --cwd $dir -- $EDITOR
wezterm cli spawn --window-id $window_id --cwd $dir -- zsh -l
wezterm cli spawn --window-id $window_id --cwd $dir -- yazi
wezterm cli activate-tab --pane-id $pane_id --tab-index 0
wezterm cli kill-pane --pane-id $pane_id
