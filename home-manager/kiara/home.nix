{ pkgs, inputs, outputs, ... }:

let
  inherit (inputs.nix-colors) colorSchemes;
in
{
  home.enableNixpkgsReleaseCheck = false;

  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./desktop.nix
    ./dotfiles.nix
    ./dunst.nix
    ./emacs.nix
    ./font.nix
    ./gammastep.nix
    ./git.nix
    # ./gnome/default.nix
    ./gtk.nix
    ./hyprland.nix
    ./kanshi.nix
    ./kitty.nix
    ./mako.nix
    ./mime.nix
    ./rofi.nix
    ./swaylock.nix
    ./systemd-fixes.nix
    ./tty-init.nix
    ./waybar.nix
    ./wezterm.nix
    ./wofi.nix
    ./zathura.nix
    ./zsh.nix
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  colorscheme = colorSchemes.atelier-dune;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kiara";
  home.homeDirectory = "/home/kiara";

  # https://github.com/NixOS/nixpkgs/issues/245772#issuecomment-1675034089
  manual.manpages.enable = false;

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 48;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    nixFlakes
    cached-nix-shell
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
    xorg.xev
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
    gnome.gnome-tweaks
    dconf2nix
    vscodium
    libreoffice-fresh
    thefuck
    pass
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
    evince
    calibre
    browserpass
    offlineimap
    kdeconnect
    vlc
    ffmpeg
    gnome.gnome-music
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
    ]))
    yarn
    sqlite
    zlib
    unzip
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
    marble
    gnome.gnome-maps
    sshfs
    gettext
    arduino-cli
    arduino
    xclip
    waybar
    gnome.nautilus
    # dolphin # hijacks folder mime-type `inode/directory`
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
    fontpreview

    # wallpapers
    mpvpaper # video
    swww # animated transitions
    waypaper # frontend

    # LSP
    nil nixpkgs-fmt

    # configure-gtk
    wayland
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    dracula-theme # gtk theme
    grim # screenshot functionality
    bemenu # wayland clone of dmenu
    wdisplays # tool to configure displays

    # notifications
    dunst
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
