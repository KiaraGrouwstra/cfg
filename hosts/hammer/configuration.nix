# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  userConfig,
  ...
}: let
  nixPath = "/run/current-system/nixpkgs";
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  boot = {
    initrd.systemd = {
      enable = true;
      emergencyAccess = false; # config.users.users.kiara.hashedPassword;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    # Bootloader
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = false;
    loader.grub.theme = pkgs.sleek-grub-theme;
    # Windows disks
    supportedFilesystems = ["ntfs"];
  };

  environment.etc."machine-id".text = "26aa8d2d944441d7b2944058d4e69fb0";

  # # Setup keyfile
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

  # nitrokey
  # security.pam.p11.enable = true;

  # printing
  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users = {
    mutableUsers = false;

    # generate password hash by `mkpasswd -m sha-512 mySuperSecretPassword`
    users = {
      # root.hashedPasswordFile = config.sops.secrets.user-password-root.path;

      kiara = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets.user-password-kiara.path;
        description = "輝愛来 (kiara)";
        extraGroups = [
          "input"
          "video"
          "networkmanager"
          "wheel"
          "adbusers"
          "docker"
          "libvirtd"
        ];
        shell = pkgs.zsh;
      };
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs = {
    light.enable = true;
    adb.enable = true;
    mtr.enable = true;
    zsh.enable = true;
    browserpass.enable = true;
    thunar.enable = true;
    plotinus.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  environment.systemPackages = with pkgs; [
    nix-schema
  ];

  environment.shells = with pkgs; [zsh];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # needed for gnupg
  services.pcscd.enable = true;
  services.dbus.packages = [pkgs.gcr];
  # if not working run: `pkill gpg-agent`

  # location
  services.geoclue2 = {
    enable = true;
    enableWifi = true;
  };

  # screensharing
  services.pipewire.wireplumber.enable = true;

  environment.variables = {
    XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory: https://discourse.nixos.org/t/login-keyring-did-not-get-unlocked-hyprland/40869
    XDG_CONFIG_HOME = "$HOME/.config";
    NIXOS_OZONE_WL = "1"; # electron
    QT_STYLE_OVERRIDE = "kvantum";
    # # qt wayland: https://discourse.nixos.org/t/problem-with-qt-apps-styling/29450/8
    # QT_QPA_PLATFORM = "wayland";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  services.flatpak.enable = true;

  # https://github.com/NixOS/nixpkgs/pull/210453#issuecomment-1410035331
  nixpkgs.config.firefox.speechSynthesisSupport = true;

  sops = {
    age.keyFile = "/persist${userConfig.home}/.config/sops/age/keys.txt"; # must have no password!
    # It's also possible to use a ssh key, but only when it has no password:
    #age.sshKeyPaths = [ "/home/user/path-to-ssh-key" ];
    defaultSopsFile = ../../secrets.enc.yml;
    secrets = {
      age-keys = {};
      user-password-kiara.neededForUsers = true;
    };
  };

  services.gnome = {
    at-spi2-core.enable = true; # orca
    gnome-keyring.enable = true; # flare-signal
  };

  # let file managers access trash and remotes
  services.gvfs.enable = true;

  systemd.services.local-ai = let
    port = "8080";
  in {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.local-ai}/bin/local-ai --address :${port} --models-path /persist${userConfig.home}/.config/piper/voices/";
  };

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    # If true, the time when the service unit was last triggered is stored on disk.
    # When the timer is activated, the service unit is triggered immediately if it would
    # have been triggered at least once during the time when the timer was inactive.
    # Such triggering is nonetheless subject to the delay imposed by RandomizedDelaySec=.
    # This is useful to catch up on missed runs of the service when the system was powered down.
    persistent = true;
    # not too frequent to prevent wiping progress from failed builds.
    dates = "weekly";
    # delete old builds
    options = "--delete-older-than 7d";
  };
  # keep the system responsive, good for devices in use
  nix.daemonCPUSchedPolicy = "idle";

  # use flake's nixpkgs over channels
  system.extraSystemBuilderCmds = ''
    ln -sv ${pkgs.path} $out/nixpkgs
  '';
  nix.nixPath = ["nixpkgs=${nixPath}"];
  systemd.tmpfiles.rules = [
    "L+ ${nixPath} - - - - ${pkgs.path}"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
