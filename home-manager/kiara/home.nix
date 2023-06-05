{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kiara";
  home.homeDirectory = "/home/kiara";

  # If I can't dance to it, it's not my revolution. - Emma Goldman
  gtk = {
    enable = true;

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
    };

    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper-Mono-Dark";
    };

    theme = {
      package = pkgs.adementary-theme;
      name = "Adementary-dark";
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    nixFlakes
    gnumake
    glib
    zip
    mtr
    vim
    wget
    curl
    git
    git-crypt # sudo ln -s $(which git-crypt) /usr/bin/git-crypt
    gnupg
    pinentry-gtk2
    zsh
    amp
    wezterm
    usbutils
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
    any-nix-shell
    appimage-run
    paper-icon-theme
    adementary-theme
    bibata-cursors
    emacsPackages.guix
    keepassxc
    podman-compose
    texlive.combined.scheme-minimal
    tealdeer
    calibre
    okular
    browserpass
    offlineimap
    kdeconnect
    gnomeExtensions.random-wallpaper
    vlc
    ffmpeg
    gnome.gnome-music
    stremio  # adds providers for content, e.g. https://torrentio.strem.fun/
    # webtorrent_desktop
    nodePackages.webtorrent-cli
    gimp
    borgbackup
    borgmatic
    vorta
    android-tools
    nextcloud-client
    chromium
    direnv
    nix-direnv
    asdf-vm
    gcc
    python311
    python311Packages.bootstrapped-pip
    yarn
    sqlite
    mariadb
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gtk2";
  };

  services.lorri = {
    enable = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [
      nix-mode
      magit
      tramp
      notmuch
      offlineimap
      org
      direnv
    ];
  };
  programs.offlineimap.enable = true;

  # installed apps don’t show up in "Show Applications"
  # https://github.com/nix-community/home-manager/issues/1439#issuecomment-1106208294
  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = ''
        rm -rf ${config.xdg.dataHome}/"applications/home-manager"
        mkdir -p ${config.xdg.dataHome}/"applications/home-manager"
        cp -Lr ${config.home.homeDirectory}/.nix-profile/share/applications/* ${config.xdg.dataHome}/"applications/home-manager/"
      '';
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "text/calendar" = [ "org.gnome.Calendar.desktop" ];
    "application/pdf" = [ "evince.desktop" ];
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "git"
        "thefuck"
      ];
      theme = "agnoster";
    };
    sessionVariables = {
      EDITOR = "amp";
      VISUAL = "amp";
    };
    shellAliases = {
      docker-compose = "podman-compose";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

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

  xdg.configFile = {
    ".gitignore" = {
      source = ./dotfiles/.gitignore;
    };
  };

}
