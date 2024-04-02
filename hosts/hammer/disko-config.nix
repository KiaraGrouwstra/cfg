{pkgs, inputs, ...}:
{
  imports = [
    inputs.disko.nixosModules.disko
    ./disks.nix
  ];

  # TODO: and for other persistent subvols needed for boot?
  # e.g.: root? nix? swap? log?
  # foosteros does this only for /persist and /state, so... maybe i'm good?
  fileSystems."/persist".neededForBoot = true;

  boot.initrd.systemd.extraBin = {
    find = "${pkgs.findutils}/bin/find";
    sed = "${pkgs.busybox}/bin/sed";
    xargs = "${pkgs.findutils}/bin/xargs";
  };

  # https://github.com/lilyinstarlight/foosteros/blob/main/hosts/bina/disks.nix
  boot.initrd.systemd.services.create-root = {
    description = "Rolling over and creating new filesystem root";

    requires = [ "initrd-root-device.target" ];
    after = [ "initrd-root-device.target" ];
    requiredBy = [ "initrd-root-fs.target" ];
    before = [ "sysroot.mount" ];

    unitConfig = {
      AssertPathExists = "/etc/initrd-release";
      DefaultDependencies = false;
    };

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      mkdir -p /run/rootvol
      mount -t btrfs -o rw,subvol=/ /dev/nixos/root /run/rootvol

      num="$(printf '%s\n' "$(find /run/rootvol -mindepth 1 -maxdepth 1 -type d -name 'root-*')" | sed -e 's#^\s*$#0#' -e 's#^/run/rootvol/root-\(.*\)$#\1#' | sort -n | tail -n 1 | xargs -I '{}' expr 1 + '{}')"

      mv /run/rootvol/root /run/rootvol/root-"$num"
      btrfs property set /run/rootvol/root-"$num" ro true

      btrfs subvolume create /run/rootvol/root
      btrfs subvolume set-default /run/rootvol/root

      find /run/rootvol -mindepth 1 -maxdepth 1 -type d -name 'root-*' | sed -e 's#^/run/rootvol/root-\(.*\)$#\1#' | sort -n | head -n -30 | xargs -I '{}' sh -c "btrfs property set '/run/rootvol/root-{}' ro false && btrfs subvolume list -o '/run/rootvol/root-{}' | cut -d' ' -f9- | xargs -I '[]' btrfs subvolume delete '/run/rootvol/[]' && btrfs subvolume delete '/run/rootvol/root-{}'"

      umount /run/rootvol
      rmdir /run/rootvol
    '';
  };
}
