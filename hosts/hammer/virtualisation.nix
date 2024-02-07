{ lib, config, pkgs, ... }:

with lib;

let cfg = config.toggles.virtualisation;
in {
  options.toggles.virtualisation.enable = mkEnableOption "virtualisation";

  # imports = lib.optionals cfg.enable [
  # ];

  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      qemu
    ];

    programs.extra-container.enable = true;

    users.extraGroups.vboxusers.members = [
      "kiara"
    ];

    nixpkgs.config.allowUnfreePredicate = pkg: lib.elem (lib.getName pkg) [
      "vmware"
    ];

    virtualisation = {

      virtualbox = {
        host = {
          enable = true;
          enableExtensionPack = true;
        };
        guest = {
          enable = true;
          # x11 = false;
        };
      };

      vmware = {
        host = {
          enable = true;
          # package = pkgs.vmware-workstation;
          # extraConfig = "";
          # extraPackages = [];
        };
        guest = {
          enable = true;
          # headless = true;
        };
      };

      # to use podman with ports as low as 80 run:
      # sudo sysctl net.ipv4.ip_unprivileged_port_start=80
      podman = let
        dockerEnabled = config.virtualisation.docker.enable;
      in {
        enable = true;
        # Create a `docker` alias for podman, to use it as a drop-in replacement
        # NOTE: this doesn't replace Docker Swarm
        dockerCompat = !dockerEnabled;
        dockerSocket.enable = !dockerEnabled;
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

      # https://nixos.wiki/wiki/WayDroid
      waydroid.enable = true;

      # libvirtd
      libvirtd.enable = true;
    };
    programs.dconf.enable = true;

    programs.singularity = {
      enable = true;
      package = pkgs.apptainer;
    };

  };
}
