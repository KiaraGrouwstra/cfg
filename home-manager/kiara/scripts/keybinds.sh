#!/usr/bin/env -S nix shell nixpkgs#wl-clipboard nixpkgs#jaq nixpkgs#gum nixpkgs#hyprland --command bash
# show keybindings

# unfortunately messy as bash won't retain strings as multi-line when stored in variables

hyprctl binds -j | jaq -r '
.[] |
(.modmask|
    (if (.
        | (if . >= 64 then . - 64 else . end)
        | (if . >= 8 then . - 8 else . end)
        | . >= 4
    ) then "ctrl " else "" end) +
    (if (.
        | (if . >= 64 then . - 64 else . end)
        | . >= 8
    ) then "alt " else "" end) +
    (if (.
        | (if . >= 64 then . - 64 else . end)
        | (if . >= 8 then . - 8 else . end)
        | (if . >= 1 then . - 1 else . end)
        | . >= 1
    ) then "shift " else "" end) +
    (if (. >= 64) then "super " else "" end)
) +
" " +
.key + ": " +
.dispatcher + " " +
.arg
' | sed -E 's#/nix/store/[^/]+\/bin\/###g' | gum filter --no-limit | wl-copy

# # the mod mask is as follows:
# 64: super
# # 32: ?
# # 16: ?
# 8: alt
# 4: ctrl
# # 2: ?
# 1: shift

# for simplicity i'm ignoring modifiers i haven't used,
# as my algorithm is clunky lacking proper bit-wise operators:
# https://stackoverflow.com/a/45623173/1502035
