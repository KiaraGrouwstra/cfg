{ pkgs, lib, inputs, outputs, unfree, ... }:

{
  home.enableNixpkgsReleaseCheck = false;

  imports = [
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
  ] ++ (lib.attrValues outputs.homeManagerModules);

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kiara";
  home.homeDirectory = "/home/kiara";

  # https://github.com/NixOS/nixpkgs/issues/245772#issuecomment-1675034089
  manual.manpages.enable = false;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.frappeDark;
    name = "Catppuccin-Frappe-Dark-Cursors";
    size = 48;
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
    pinentry-curses
    wev
    zsh
    jq
    amp
    helix
    wezterm
    usbutils
    firefox
    thunderbird
    signal-desktop
    telegram-desktop
    dconf2nix
    vscodium
    libreoffice-fresh
    thefuck
    pass
    any-nix-shell
    appimage-run
    emacsPackages.guix
    keepassxc
    podman-compose
    texlive.combined.scheme-full
    tealdeer
    evince
    calibre
    browserpass
    offlineimap
    kdeconnect
    vlc
    pamixer
    pavucontrol
    cava
    spotify-tui
    spotify-player
    deadbeef
    cmus
    musikcube
    ncmpcpp
    ffmpeg
    gnome.gnome-music
    mpv
    imv
    stremio  # adds providers for content, e.g. https://torrentio.strem.fun/
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
      nautilus-open-any-terminal
      # ^ manually patch gsettings: https://github.com/NixOS/nixpkgs/issues/259586#issuecomment-1752107159
      pandas
      ipython
      ipython-sql
      yowsup
    ]))
    yarn
    sqlite
    zlib
    unzip
    pandoc
    element-desktop
    docker-compose
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
    virt-manager
    obs-studio
    woodpecker-cli
    git-interactive-rebase-tool
    nodePackages.markdownlint-cli
    prusa-slicer
    cura
    curaengine
    octoprint
    rpi-imager
    arduinoOTA
    gnome.dconf-editor
    lapce
    peek
    subversion
    imagemagick
    idris2
    hvm
    gnome.gnome-maps
    sshfs
    gettext
    arduino-cli
    arduino
    xclip
    waybar
    gnome.nautilus
    bruno
    hyprpicker
    wayshot
    watershot
    wl-screenrec
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    wl-clip-persist # make clipboard persist across app close
    cliphist
    swayidle
    slurp
    scrot
    libsForQt5.kasts
    lynx
    playerctl
    monitor
    gnome.gnome-system-monitor
    cage
    xxh
    desktop-file-utils
    handlr
    mimeo
    remarshal
    gnome.gnome-characters
    networkmanager_dmenu
    pywal
    wpgtk
    fontpreview
    htop
    unixtools.column
    poppler_utils
    pdf2odt
    xsv
    csvkit
    neomutt
    newsboat
    castget
    dex
    eza
    unfree.zoom-us
    hydroxide
    tor-browser
    onionshare-gui

    # chat
    signal-cli
    scli
    matrix-commander

    # wallpapers
    swww # animated transitions
    waypaper # frontend

    # LSP
    nil nixpkgs-fmt

    # configure-gtk
    wayland
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    grim # screenshot functionality
    wdisplays # tool to configure displays

    # notifications
    libnotify
    swaynotificationcenter

    # image viewers:
    libsForQt5.koko
    swayimg
    vimiv-qt
    oculante
    gwenview
    libsForQt5.pix
    gnome.eog

    # markdown:
    glow
    ghostwriter
    apostrophe
    okular
    mdcat

    # text editors:
    featherpad
    libsForQt5.kate
    nota
    gnome-text-editor

    # qutebrowser  # needs recent nixpkgs
    gitui

    # file browser
    ranger
    mc

    # speech
    espeak-classic
    piper-tts
    yasr
    orca
    openai-whisper

  ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      nvchad
      nvchad-ui
    ];
  };

  programs.lesspipe.enable = true;

  services.playerctld.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";
  };

  services.lorri = {
    enable = true;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
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

  programs.eww = {
    enable = true;
    configDir = ./dotfiles/eww;
  };

  # used by enhancd
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  services.syncthing.enable = true;

  programs.command-not-found.enable = true;

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
