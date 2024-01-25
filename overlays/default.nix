# Packages you want to overlay.
# You can change versions, add patches, set compilation flags, anything really.
# https://nixos.wiki/wiki/Overlays
{ pkgs, ... }:

with pkgs; {

  weechat = import ./weechat.nix { inherit pkgs; };

}
