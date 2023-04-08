{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kiara";
  home.homeDirectory = "/home/kiara";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    vim
    wget
    curl
    git
    gnupg
    pinentry-gtk2
    zsh
    emacs
    amp
    wezterm
    firefox
    thunderbird
    signal-desktop-beta
    gnome.gnome-tweaks
    vscodium
    libreoffice-fresh
    thefuck
    pass
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-search-multi-word
    paper-icon-theme
    adementary-theme
    bibata-cursors
    emacsPackages.guix
    keepassxc
    podman-compose
    texlive.combined.scheme-minimal
    tealdeer
    browserpass
    most
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gtk2";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # (why does their nix-channel also have a 22.11?)
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
