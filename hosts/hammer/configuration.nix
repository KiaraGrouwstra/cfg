# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, outputs, ... }:

{
  imports =
    [
      ./imports.nix
      inputs.home-manager.nixosModules.home-manager
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
    libsForQt5.qtstyleplugin-kvantum
    ssh-to-age
  ];

  programs = {
    light.enable = true;
    adb.enable = true;
    mtr.enable = true;
    zsh.enable = true;
    browserpass.enable = true;
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

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    # This will become a global environment variable
    GDK_BACKEND = "wayland"; # gtk
    # NIXOS_OZONE_WL = "1";    # electron, breaks codium now
    QT_STYLE_OVERRIDE = "kvantum";
  };

  services.flatpak.enable = true;

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
    };
  };

  services.gnome.at-spi2-core.enable = true; # orca

  services.gnome.gnome-keyring.enable = true; # flare-signal

  # used by enhancd
  programs.fzf.fuzzyCompletion = true;

  # https://mynixos.com/nixpkgs/options/services.nomad
  services.nomad = {
    enable = true;
    package = pkgs.nomad_1_6;
    dropPrivileges = false;  # Nomad as Root to access Docker/Podman sockets (>nomad_1_4) and exec driver
    enableDocker = true;
    credentials = {};
    extraPackages = with pkgs; [
      cni-plugins   # client.fingerprint_mgr.cni_plugins: failed to read CNI plugins directory: cni_path=/opt/cni/bin error="open /opt/cni/bin: no such file or directory"
    ];
    extraSettingsPlugins = with pkgs; [
      nomad-driver-podman
      nomad-driver-nix
      nomad-driver-nix2
      nomad-driver-singularity

      # hcloud-csi-driver
      # hcloud-csi-driver: The cluster nodes need to have the docker driver installed & configured with `allow_privileged = true`.
    ];
    # https://developer.hashicorp.com/nomad/docs/configuration
    settings = {
      bind_addr = "0.0.0.0"; # the default
      # advertise = {
      #   # Defaults to the first private IP address.
      #   http = "1.2.3.4";
      #   rpc  = "1.2.3.4";
      #   serf = "1.2.3.4:5648"; # non-default ports may be specified
      # };
      server = {
        enabled = true;
        bootstrap_expect = 1; # for demo; no fault tolerance
      };
      client = {
        enabled = true;
      };
      plugin = {
        # https://developer.hashicorp.com/nomad/docs/drivers/raw_exec#plugin-options
        raw_exec = {
          config = {
            enabled = true;
          };
        };
        # # https://developer.hashicorp.com/nomad/docs/drivers/exec#plugin-options
        # exec = {
        #   config = {};
        # };
        # # https://developer.hashicorp.com/nomad/docs/drivers/qemu#plugin-options
        # qemu = {
        #   config = {};
        # };
        # https://developer.hashicorp.com/nomad/docs/drivers/docker#plugin-options
        docker = {
          config = {
            allow_privileged = true; # for hcloud-csi-driver cluster nodes need this
          };
        };
        # https://developer.hashicorp.com/nomad/plugins/drivers/podman#plugin-options
        nomad-driver-podman = {
          config = {
            disable_log_collection = true;
            # gc.container = true;
            # volumes.enabled = true;
          };
        };
        # https://developer.hashicorp.com/nomad/plugins/drivers/community/singularity#plugin-options
        nomad-driver-singularity = {
          config = {
            enabled = true;
            # singularity_path = "/var/lib/singularity";
          };
        };
        # https://developer.hashicorp.com/nomad/plugins/drivers/community/containerd#plugin-options
        containerd-driver = {
          config = {
            enabled = true;
            containerd_runtime = "io.containerd.runc.v2";
            allow_privileged = true;
          };
        };
        # https://github.com/input-output-hk/nomad-driver-nix/blob/main/example/agent.hcl
        nix-driver = {
          config = {
          };
        };
        # https://git.deuxfleurs.fr/Deuxfleurs/nomad-driver-nix2/src/branch/main/example/agent.hcl
        nix2-driver = {
          config = {
            # default_nixpkgs = "github:nixos/nixpkgs/nixos-22.05";
          };
        };
        # https://github.com/MagicRB/nomad-driver-containerd-nix/blob/master/extra_config.hcl
        nomad-driver-containerd = {  # also `containerd-driver`?
          config = {
            enabled = true;
            # containerd_runtime = "io.containerd.runc.v2";
            # stats_interval = "5s";
          };
        };
      };
      # consul = {
      #   address = "1.2.3.4:8500";
      # };
    };
  };

  # I don't need Nomad starting when the system boots.
  systemd.services.nomad.wantedBy = lib.mkForce [ ];

  services.consul = {
    enable = true;
  };

  services.vault = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

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
    options = "--delete-older-than 21d";
  };
  # keep the system responsive, good for devices in use
  nix.daemonCPUSchedPolicy = "idle";

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
