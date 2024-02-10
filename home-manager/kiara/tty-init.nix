{ config, ... }:

{
  programs = {
    # fish.loginShellInit = ''
    #   if test (tty) = "/dev/tty1"
    #     exec Hyprland &> /dev/null
    #   end
    # '';
    zsh.loginExtra = if config.wayland.windowManager.hyprland.enable then ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '' else "";
    zsh.profileExtra = if config.wayland.windowManager.hyprland.enable then ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '' else "";
  };
}
