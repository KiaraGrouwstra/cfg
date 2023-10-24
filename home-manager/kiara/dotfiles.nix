{ config, pkgs, ... }:

{

  # must `git add .` or new files won't be found
  home.file = {
    "Templates/Untitled.md".text = "";
    "Templates/Untitled.odt".source = ./dotfiles/Templates/Untitled.odt;
    "Templates/Untitled.ods".source = ./dotfiles/Templates/Untitled.ods;
    "Templates/Untitled.odp".source = ./dotfiles/Templates/Untitled.odp;
    ".face".source = ./dotfiles/.face;
    ".ssh/config".source = ./dotfiles/.ssh/config;
    ".config/amp/config.yml".source = ./dotfiles/.config/amp/config.yml;
    ".config/amp/syntaxes/nix.sublime-syntax".source = ./dotfiles/.config/amp/syntaxes/nix.sublime-syntax;
    # ".config/sops/age/keys.txt".source = config.sops.secrets.age-keys.path; # $SOPS_AGE_KEY_FILE # error: attribute 'sops' missing
  };

}
