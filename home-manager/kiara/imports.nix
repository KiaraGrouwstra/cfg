{ ... }:

{

  imports = [
    ./features/default.nix

    ./colors.nix
    ./desktop.nix
    ./dotfiles.nix
    ./emacs.nix
    ./font.nix
    ./gammastep.nix
    ./git.nix
    # ./gnome/default.nix
    ./gtk.nix
    ./hyprland.nix
    ./kanshi.nix
    ./kitty.nix
    ./mime.nix
    ./neomutt.nix
    ./rofi.nix
    ./swaylock.nix
    ./systemd-fixes.nix
    ./tty-init.nix
    ./waybar.nix
    ./wezterm.nix
    ./wofi.nix
    ./zathura.nix
    ./zsh.nix
  ];

}
