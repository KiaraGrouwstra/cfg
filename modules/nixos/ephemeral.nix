{
  lib,
  config,
  ...
}: {
  # https://github.com/trueNAHO/os/blob/master/modules/impermanence/nixos/default.nix
  options.modules.impermanence.nixos = {
    btrfsSubvolumes = {
      enable = lib.mkEnableOption "Btrfs subvolume darling erasure";

      rootFilesystem = lib.mkOption {
        description = "Path to the Btrfs root filesystem.";
        example = "/dev/mapper/luks";
        type = lib.types.str;
      };

      rootSubvolume = lib.mkOption {
        description = "Name of the Btrfs root subvolume.";
        example = "root";
        type = lib.types.str;
      };
    };

    enable = lib.mkEnableOption "impermanence";

    path = lib.mkOption {
      description = "Path to the persistent storage directory.";
      example = "/persistent";
      type = lib.types.str;
    };
  };

  config = let
    cfg = config.modules.impermanence.nixos;
  in
    lib.mkIf cfg.enable {
      # https://discourse.nixos.org/t/impermanence-vs-systemd-initrd-w-tpm-unlocking/25167/3
      boot.initrd.systemd.services.wipe-root = lib.mkIf cfg.btrfsSubvolumes.enable {
        description = "Rollback BTRFS root subvolume to a pristine state";
        wantedBy = ["initrd.target"];
        after = ["dev-mapper-crypted.device"]; # LUKS process
        requires = ["dev-mapper-crypted.device"];
        before = ["sysroot.mount"];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          (
            set -xe

            btrfs_subvolume_delete_recursive() {
              btrfs subvolume list -o "$1" |
                cut -f 9- -d ' ' |
                while read -r subvolume; do
                  btrfs_subvolume_delete_recursive "$mount_point/$subvolume"
                done

              btrfs subvolume delete "$1"
            }

            mount_point=/mnt
            mkdir -p "$mount_point"
            mount -t btrfs "${cfg.btrfsSubvolumes.rootFilesystem}" "$mount_point"

            trap 'umount "$mount_point" && rmdir "$mount_point"' EXIT

            btrfs_subvolume_delete_recursive \
              "$mount_point/${cfg.btrfsSubvolumes.rootSubvolume}"

            btrfs subvolume create "$mount_point/${cfg.btrfsSubvolumes.rootSubvolume}"
          )
        '';
      };

      fileSystems = {
        # https://github.com/ryantm/agenix/issues/45#issuecomment-957865406
        "/etc/ssh" = {
          depends = [cfg.path];
          neededForBoot = true;
        };

        ${cfg.path}.neededForBoot = true;
      };
    };
}
