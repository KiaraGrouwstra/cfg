{
  config,
  userConfig,
  ...
}: let
  inherit (config.commands) nvimpager terminal zsh;
in {
  home.enableNixpkgsReleaseCheck = false;

  imports = [./imports.nix];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kiara";
  home.homeDirectory = "/home/kiara";

  # set shell in home-manager
  xdg.configFile."shell".source = zsh;

  # keyboard.active = "workman";

  home.sessionVariables = {
    SHELL = zsh;
    PAGER = nvimpager;
    MANPAGER = "$PAGER";
    TERMINAL = terminal;
    # TERM     = terminal; # breaks gpg with error 'screen or window too small'
    EDITOR = "hx";
    VISUAL = "hx";
    BROWSER = "firefox";
    DISPLAY = ":0"; # xwayland-satellite.service
  };

  home.persistence."/persist${userConfig.home}".allowOther = false;

  sops = {
    age.keyFile = "/persist${userConfig.home}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets.enc.yaml;
    # $HOME/.config/sops-nix/secrets
    secrets = {
      github-pat = {};
      dav-pw = {};
    };
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
  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
