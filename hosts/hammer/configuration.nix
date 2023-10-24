# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./databases.nix
      ./fonts.nix
      # ./gnome.nix
      ./guix.nix
      ./hyprland.nix
      ./locale.nix
      ./networking.nix
      ./sound.nix
      ./virtualisation.nix
      inputs.sops-nix.nixosModules.sops
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # # Setup keyfile
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

  # X11
  services.xserver.enable = true;

  security.polkit.enable = true;

  # nitrokey
  # security.pam.p11.enable = true;

  # swaylock
  security.pam.services = {
    swaylock = {
      text = ''
        auth include login
      '';
      showMotd = true;
      # p11Auth = true;
      # enableGnomeKeyring = true;
      # enableKwallet = true;
    };
  };

  # keymap in X11
  services.xserver = {
    layout = "us,nl";
    xkbVariant = "";
  };

  # printing
  services.printing.enable = true;

  hardware.bluetooth.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.kiara = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.user-password-kiara.path;
    description = "輝愛来 (kiara)";
    extraGroups = [
      "video"
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
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    ENERGY_PERF_POLICY_ON_BAT = "powersave";
  };

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
    sops
    rage
    inputs.nix-software-center.packages.${system}.nix-software-center
    inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    gnome.nautilus-python
    zoom-us
    libsForQt5.qtstyleplugin-kvantum
  ];

  programs = {
    light.enable = true;
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

  services.locate = {
    enable = true;
    package = pkgs.mlocate;
    localuser = null;
  };

  programs.dconf.enable = true;

  programs.plotinus.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  environment.variables = {
    # This will become a global environment variable
    "QT_STYLE_OVERRIDE"="kvantum";
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

  # TODO: move to fonts.nix once that works
  fonts.packages = with pkgs; [
    powerline-fonts
    twemoji-color-font
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
  ];

  sops = {
    age.keyFile = "/etc/nixos/keys.txt"; # must have no password!
    # It's also possible to use a ssh key, but only when it has no password:
    #age.sshKeyPaths = [ "/home/user/path-to-ssh-key" ];
    defaultSopsFile = ../../secrets.enc.yml;
    secrets = {
      age-keys = {};
      user-password-kiara.neededForUsers = true;
      wifi-home-password = {};
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
