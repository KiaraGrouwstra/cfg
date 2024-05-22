{
  config,
  userConfig,
  ...
}: {
  home.enableNixpkgsReleaseCheck = false;

  imports = [./imports.nix];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kiara";
  home.homeDirectory = "/home/kiara";

  # keyboard.active = "workman";

  home.sessionVariables = with config.commands; {
    PAGER = nvimpager;
    MANPAGER = "$PAGER";
    TERMINAL = terminal;
    # TERM     = terminal; # breaks gpg with error 'screen or window too small'
    EDITOR = "hx";
    VISUAL = "nvim";
    BROWSER = "firefox";
  };

  home.persistence."/persist${userConfig.home}".allowOther = false;

  sops = {
    age.keyFile = "/persist${userConfig.home}/.config/sops/age/keys.txt";
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
