{ config, pkgs, ... }:

{

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
    # https://nixos.wiki/wiki/WayDroid
    waydroid.enable = true;
    # libvirtd
    libvirtd.enable = true;
  };
  programs.dconf.enable = true;

}
