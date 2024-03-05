{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  home.enableNixpkgsReleaseCheck = false;

  imports = [./imports.nix];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kiara";
  home.homeDirectory = "/home/kiara";

  home.sessionVariables = with (import ./commands.nix {inherit pkgs inputs;}); {
    # `nixos-option`
    # qt wayland: https://github.com/keepassxreboot/keepassxc/issues/2973
    QT_QPA_PLATFORM = "wayland";
    ECORE_EVAS_ENGINE = "wayland_egl";
    ELM_ENGINE = "wayland_egl";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    PAGER = "${gum} pager";
  };

  sops = {
    age.keyFile = "/etc/nixos/keys.txt";
    defaultSopsFile = ../../secrets.enc.yml;
  };

  # https://github.com/NixOS/nixpkgs/issues/245772#issuecomment-1675034089
  manual.manpages.enable = false;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
