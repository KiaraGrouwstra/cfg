# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./hardware-configuration.nix
      ./adblock.nix
      ./databases.nix
      # ./gnome.nix
      ./greetd.nix
      ./guix.nix
      ./hyprland.nix
      # ./lightdm.nix
      ./locale.nix
      ./power.nix
      ./networking.nix
      ./sound.nix
      ./virtualisation.nix
      inputs.sops-nix.nixosModules.sops
    ] ++ (lib.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = { inherit inputs outputs; };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    # Bootloader
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    # Windows disks
    supportedFilesystems = [ "ntfs" ];
  };

  # # Setup keyfile
  # boot.initrd.secrets = {
  #   "/crypto_keyfile.bin" = null;
  # };

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

  services.xserver.displayManager = {
    autoLogin = {
      enable = true;
      user = "kiara";
    };
  };

  services.xserver.displayManager.session = [];

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
    libsForQt5.qtstyleplugin-kvantum
    ssh-to-age
  ];

  programs = {
    light.enable = true;
    adb.enable = true;
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

  # location
  services.geoclue2 = {
    enable = true;
    enableWifi = true;
  };

  # screensharing
  services.pipewire.wireplumber.enable = true;

  programs.dconf.enable = true;

  programs.plotinus.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    # This will become a global environment variable
    GDK_BACKEND = "wayland"; # gtk
    # NIXOS_OZONE_WL = "1";    # electron, breaks codium now
    QT_STYLE_OVERRIDE = "kvantum";
  };

  services.flatpak.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
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
      wifi-password-home = {};
      wifi-password-woerden = {};
      wifi-password-publicroam = {};
      wifi-password-eduroam = {};
    };
  };

  services.gnome.at-spi2-core.enable = true; # orca

  # used by enhancd
  programs.fzf.fuzzyCompletion = true;

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    persistent = true;
    options = "--delete-older-than 21d";
  };

  # use flake's nixpkgs over channels
  system.extraSystemBuilderCmds = ''
    ln -sv ${pkgs.path} $out/nixpkgs
  '';
  nix.nixPath = [ "nixpkgs=flake:nixpkgs" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
