{ config, pkgs, ... }:

{

  wayland.windowManager.hyprland = {
    enable = true;
    # systemd service needed for kanshi
    systemd.enable = true;
    # settings = {};
    extraConfig = (builtins.readFile dotfiles/.config/hypr/hyprland.conf);
  };

}
