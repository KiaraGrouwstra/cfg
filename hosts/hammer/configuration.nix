# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # # Setup keyfile
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT    = "nl_NL.UTF-8";
    LC_MONETARY       = "nl_NL.UTF-8";
    LC_NAME           = "nl_NL.UTF-8";
    LC_NUMERIC        = "nl_NL.UTF-8";
    LC_PAPER          = "nl_NL.UTF-8";
    LC_TELEPHONE      = "nl_NL.UTF-8";
    LC_TIME           = "nl_NL.UTF-8";
  };

  # X11
  services.xserver.enable = true;

  # GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.defaultSession = "gnome";

  # keymap in X11
  services.xserver = {
    layout = "us,nl";
    xkbVariant = "";
  };

  # printing
  services.printing.enable = true;

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  hardware.bluetooth.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.kiara = {
    isNormalUser = true;
    description = "輝愛来 (kiara)";
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "docker"
      "libvirtd"
    ];
    shell = pkgs.zsh;
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "kiara";

  # See https://linrunner.de/en/tlp/docs/tlp-faq.html#battery
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=75
    STOP_CHARGE_THRESH_BAT0=80
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    ENERGY_PERF_POLICY_ON_BAT=powersave
  '';

  # guix
  users.extraUsers = lib.fold (a: b: a // b) { } (builtins.map
    (i: {
      "guixbuilder${i}" = {
        group = "guixbuild";
        extraGroups = [ "guixbuild" ];
        home = "/var/empty";
        shell = pkgs.shadow;
        description = "Guix build user ${i}";
        isSystemUser = true;
      };
    }) [ "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" ]);
  users.extraGroups.guixbuild = { name = "guixbuild"; };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    epiphany
    geary
    totem
    # games:
    aisleriot
    atomix
    five-or-more
    four-in-a-row
    pkgs.gnome-2048
    gnome-chess
    gnome-klotski
    gnome-mahjongg
    gnome-mines
    gnome-nibbles
    gnome-robots
    gnome-sudoku
    gnome-taquin
    gnome-tetravex
    hitori
    iagno
    lightsoff
    quadrapassel
    swell-foop
    tali
  ]);

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    home-manager
    curl
    git
    cachix
    inputs.nix-software-center.packages.${system}.nix-software-center
    inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    gnome.nautilus-python
    zoom-us
  ];

  programs = {
    mtr.enable = true;
    zsh.enable = true;
    browserpass.enable = true;
    firefox.nativeMessagingHosts.browserpass = true;
  };

  environment.shells = with pkgs; [ zsh ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # needed for gnupg
  services.pcscd.enable = true;
  services.dbus.packages = [ pkgs.gcr ];
  # if not working run: `pkill gpg-agent`

  # Open ports in the firewall.
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  };

  services.locate.enable = true;
  services.locate.locate = pkgs.mlocate;
  services.locate.localuser = null;

  virtualisation = {
    # to use podman with ports as low as 80 run:
    # sudo sysctl net.ipv4.ip_unprivileged_port_start=80
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;
      # NOTE: this doesn't replace Docker Swarm
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      # storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    # libvirtd
    libvirtd.enable = true;
  };
  programs.dconf.enable = true;

  fonts.packages = with pkgs; [
    powerline-fonts
    twemoji-color-font
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
  ];

  programs.plotinus.enable = true;

  # /root/.config/guix/current/lib/systemd/system/guix-daemon.service
  systemd.services.guix-daemon = {
    enable = true;
    description = "Build daemon for GNU Guix";
    serviceConfig = {
      ExecStart = "/var/guix/profiles/per-user/root/current-guix/bin/guix-daemon --build-users-group=guixbuild";
      Environment = [ "GUIX_LOCPATH=/var/guix/profiles/per-user/root/guix-profile/lib/locale" "LC_ALL=en_US.utf8" ];
      RemainAfterExit = "yes";

      # See <https://lists.gnu.org/archive/html/guix-devel/2016-04/msg00608.html>.
      # Some package builds (for example, go@1.8.1) may require even more than
      # 1024 tasks.
      TasksMax = "8192";
    };
    wantedBy = [ "multi-user.target" ];
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  services.flatpak.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
    "zoom"
    "zoom-us"
  ];

  # https://github.com/NixOS/nixpkgs/pull/210453#issuecomment-1410035331
  nixpkgs.config.firefox.speechSynthesisSupport = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
