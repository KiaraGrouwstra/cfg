{
  lib,
  inputs,
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

      # https://github.com/nix-community/impermanence/blob/cd13c2917eaa68e4c49fea0ff9cada45440d7045/README.org?plain=1#L91-L157
      boot.initrd.postDeviceCommands =
        lib.mkIf
        cfg.btrfsSubvolumes.enable
        (lib.mkAfter ''
          (
            set -e

            btrfs_subvolume_delete_recursive() {
              btrfs subvolume list -o "$1" |
                awk '{ print $NF }' |
                while read -r subvolume; do
                  btrfs_subvolume_delete_recursive "$mount_point/$subvolume"
                done

              btrfs subvolume delete "$1"
            }

            mount_point="$(mktemp --directory)"
            mount -t btrfs "${cfg.btrfsSubvolumes.rootFilesystem}" "$mount_point"

            trap 'umount "$mount_point" && rmdir "$mount_point"' EXIT

            btrfs_subvolume_delete_recursive \
              "$mount_point/${cfg.btrfsSubvolumes.rootSubvolume}"

            btrfs \
              subvolume \
              create \
              "$mount_point/${cfg.btrfsSubvolumes.rootSubvolume}"
          )
        '');

      fileSystems = {
        # https://github.com/ryantm/agenix/issues/45
        "/etc/ssh" = {
          depends = [cfg.path];
          neededForBoot = true;
        };

        ${cfg.path}.neededForBoot = true;
      };
    };
}
