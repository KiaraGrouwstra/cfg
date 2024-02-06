{ pkgs, lib, inputs, config, ... }:

{

  # https://mynixos.com/nixpkgs/options/services.nomad
  services.nomad = {
    enable = true;
    package = pkgs.nomad_1_6;
    dropPrivileges = false;  # Nomad as Root to access Docker/Podman sockets (>nomad_1_4) and exec driver
    enableDocker = true;
    credentials = {};
    extraPackages = with pkgs; [
      cni-plugins   # sudo mkdir -p /opt/cni/ && sudo ln -s "${pkgs.cni-plugins}/bin" /opt/cni/bin
      inputs.nix.packages.${system}.nix
    ];
    extraSettingsPlugins = with pkgs; [
      nomad-driver-podman
      nomad-driver-nix
      nomad-driver-nix2
      nomad-driver-singularity
      # # [Unsupported plugin type](https://github.com/hashicorp/nomad/blob/a283a416139dca46b1d2e459aa033cd2d3902243/plugins/serve.go#L52)
      # nomad-driver-containerd
      # nomad-driver-containerd-nix
      # # node: unable to connect to metadata service, are you sure this is running on a Hetzner Cloud server?
      # # controller/aio: hcloud token invalid (must be exactly 64 characters long)
      # hcloud-csi-driver
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
      # https://github.com/hashicorp/nomad/issues/15471
      limits = {
        http_max_conns_per_client = 0;
        rpc_max_conns_per_client = 0;
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
            # singularity_path = "${pkgs.apptainer}/bin/apptainer";   # No argument or block type is named "singularity_path".
            # sudo mkdir -p /usr/local/bin/ &&
            # sudo ln -s "${pkgs.apptainer}/bin/apptainer" /usr/local/bin/singularity
            # sudo ln -s $(readlink -f $(which apptainer)) /usr/local/bin/singularity
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
        # i should patch the nomad-driver-containerd-nix flake build to rename it to nomad-driver-containerd-nix to deduplicate
        # nomad-driver-containerd = { config = {}; };
        # https://github.com/MagicRB/nomad-driver-containerd-nix/blob/master/extra_config.hcl
        nomad-driver-containerd = {  # also `containerd-driver`?
          config = {
            enabled = true;
            # containerd_runtime = "io.containerd.runc.v2";
            # stats_interval = "5s";
          };
        };
      };
      consul = {
        address = "localhost:8500";
      };
    };
  };

  # I don't need Nomad starting when the system boots.
  systemd.services.nomad.wantedBy = lib.mkForce [ ];

  sops.secrets.hcloud-token = {};

  # env vars needed by hetznercloud/csi-driver
  systemd.services.nomad.environment = {
    ENABLE_METRICS = "true";
    HCLOUD_TOKEN = config.sops.secrets.hcloud-token.path;
  };

  services.consul = {
    enable = true;
    dropPrivileges = true;
    webUi = true;
    alerts = {
      enable = true;
      watchChecks = true;
      watchEvents = true;
      consulAddr = "localhost:8500";
      listenAddr = "localhost:9000";
    };
    interface = {
      bind = "127.0.0.1";
      # advertise = null;
    };
    extraConfigFiles = [];
    # https://developer.hashicorp.com/consul/docs/agent/config/config-files
    extraConfig = {};
  };

  services.vault = {
    enable = true;
  };

}
