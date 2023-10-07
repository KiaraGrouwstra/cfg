{ config, pkgs, ... }:

{
  home.enableNixpkgsReleaseCheck = false;

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
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    theme = {
      package = pkgs.palenight-theme;
      name = "palenight";
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # https://github.com/NixOS/nixpkgs/issues/245772#issuecomment-1675034089
  manual.manpages.enable = false;

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
    signal-desktop
    telegram-desktop
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
    texlive.combined.scheme-full
    font-awesome
    tealdeer
    calibre
    okular
    browserpass
    offlineimap
    kdeconnect
    gnomeExtensions.random-wallpaper
    gnomeExtensions.paperwm
    gnomeExtensions.emoji-copy
    gnomeExtensions.switch-x11-wayland-default-session
    gnomeExtensions.zoom-wayland-extension
    vlc
    ffmpeg
    gnome.gnome-music
    stremio  # adds providers for content, e.g. https://torrentio.strem.fun/
    webtorrent_desktop
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
    poetry
    (python3.withPackages(ps : with ps; [
      pandas
      ipython
      ipython-sql
    ]))
    yarn
    sqlite
    zlib
    pandoc
    element-desktop
    docker-compose
    brave
    # terraform
    terraform-providers.kubernetes
    terraform-providers.helm
    kubectl
    minikube
    kubernetes-helm
    helm-dashboard
    openlens
    # k8sgpt
    argocd
    dos2unix
    speechd
    gnome.gnome-boxes  # broken: https://github.com/NixOS/nixpkgs/issues/226355
    neovim
    virt-manager
    obs-studio
    woodpecker-cli
    git-interactive-rebase-tool
    nodePackages.markdownlint-cli
    prusa-slicer
    gnome.dconf-editor
    lapce
    peek
    subversion
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

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" "lapce.desktop" "codium.desktop" ];
    "x-scheme-handler/mailto" = [ "thunderbird.desktop" ];
    "text/calendar" = [ "org.gnome.Calendar.desktop" ];
    "application/pdf" = [ "evince.desktop" ];
    "application/x-code-workspace" = [ "lapce.desktop" "codium.desktop" ];
    "text/plain" = [ "lapce.desktop" "codium.desktop" ];
    "image/jpeg"                = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/bmp"                 = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/gif"                 = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/jpg"                 = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/pjpeg"               = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/png"                 = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/tiff"                = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/webp"                = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-bmp"               = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-gray"              = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-icb"               = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-ico"               = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-png"               = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-portable-anymap"   = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-portable-bitmap"   = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-portable-graymap"  = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-portable-pixmap"   = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-xbitmap"           = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-xpixmap"           = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-pcx"               = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/svg+xml"             = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/svg+xml-compressed"  = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/vnd.wap.wbmp"        = [ "org.gnome.eog.desktop" "gimp.desktop" ];
    "image/x-icns"              = [ "org.gnome.eog.desktop" "gimp.desktop" ];
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
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
      GTK_THEME = "palenight";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    shellAliases = {
      docker-compose = "podman-compose";
    };
    initExtra = ''
                  path+=('/var/guix/profiles/per-user/root/current-guix/bin')
                  export PATH
                  export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
                  [[ $commands[kubectl] ]] && source <(kubectl completion zsh)
                '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.browserpass = {
    enable = true;
    browsers = [
      "firefox"
    ];
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/wm/keybindings" = {
      "switch-windows" = ["<Alt>Tab"];
      "switch-windows-backward" = ["<Shift><Alt>Tab"];
      "switch-applications" = ["<Super>Tab"];
      "switch-applications-backward" = ["<Super><Alt>Tab"];
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "org.wezfurlong.wezterm.desktop"
        "firefox.desktop"
        "thunderbird.desktop"
        "signal-desktop.desktop"
        "codium.desktop"
        "org.keepassxc.KeePassXC.desktop"
      ];
      # enabled-extensions = [
      #   "paperwm@hedning:matrix.org"
      # ];
    };
    "org/gnome/shell/extensions/paperwm" = {
      use-default-background = true;
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      "close-window" = ["<Super>BackSpace" "<Super>q"];
      "switch-left" = ["<Super>a" "<Super>Left"];
      "switch-right" = ["<Super>d" "<Super>Right"];
      "switch-up" = ["<Super>w" "<Super>Up"];
      "switch-down" = ["<Super>s" "<Super>Down"];
      "switch-monitor-left" = ["<Shift><Super>Left" "<Shift><Super>a"];
      "switch-monitor-right" = ["<Shift><Super>Right" "<Shift><Super>d"];
      "move-left" = ["<Control><Super>comma" "<Shift><Super>comma" "<Control><Super>Left" "<Control><Super>a" "<Alt><Super>a"];
      "move-right" = ["<Control><Super>period" "<Shift><Super>period" "<Control><Super>Right" "<Control><Super>d" "<Alt><Super>d"];
      "move-monitor-left" = ["<Shift><Control><Super>Left" "<Shift><Control><Super>a" "<Shift><Alt><Super>a"];
      "move-monitor-right" = ["<Shift><Control><Super>Right" "<Shift><Control><Super>d" "<Shift><Alt><Super>d"];
    };
    "org/gnome/desktop" = {
      "interface/show-battery-percentage" = true;
      "input-sources/xkb-options" = [
        "terminate:ctrl_alt_bksp"
        "caps:escape"
      ];
      "session/idle-delay" = 900;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      "sleep-inactive-ac-timeout" = 3600;
      "sleep-inactive-battery-timeout" = 1200;
    };
    # [microsoft keyboard](https://unix.stackexchange.com/a/714224)
    "org.gnome.shell.extensions.emoji-copy" = {
      emoji-keybinding = ["<Shift><Ctrl><Alt><Super>space"];
    };
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
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

  programs.git = {
    enable = true;
    userName  = "Kiara Grouwstra";
    userEmail = "kiara@bij1.org";
    delta.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
    ignores = [
      # Compiled source #
      ###################
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"

      # Temporary files #
      ###################
      "*.swp"
      "*.swo"
      "*~"

      # Packages #
      ############
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"

      # Logs #
      ######################
      "*.log"

      # OS generated files #
      ######################
      ".DS_Store*"
      "ehthumbs.db"
      "Icon?"
      "Thumbs.db"

      # Editor files #
      ################
      ".vscode"
    ];
    extraConfig = {
      push.autoSetupRemote = true;
      branch.autoSetupMerge = "simple";
    };
  };

  # must `git add .` or new files won't be found
  home.file = {
    ".face".source = ./dotfiles/.face;
    ".ssh/config".source = ./dotfiles/.ssh/config;
  };

}
