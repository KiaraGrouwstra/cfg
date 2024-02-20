{
  config,
  pkgs,
  ...
}:
{
  programs.extra-container.enable = true;

  virtualisation = {
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
  };
  programs.dconf.enable = true;

  programs.singularity = {
    enable = true;
    package = pkgs.apptainer;
  };
}
