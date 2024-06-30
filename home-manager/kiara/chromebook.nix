# https://wiki.nixos.org/wiki/Installing_Nix_on_Crostini
{pkgs, ...}: {
  # register desktop applications
  xdg.configFile."systemd/user/cros-garcon.service.d/override.conf".text = ''
    [Service]
    Environment="PATH=%h/.nix-profile/bin:/usr/local/sbin:/usr/local/bin:/usr/local/games:/usr/sbin:/usr/bin:/usr/games:/sbin:/bin"
    Environment="XDG_DATA_DIRS=%h/.nix-profile/share:%h/.local/share:%h/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"
  '';

  # call graphical programs with: `nixGLMesa my-program`
  home.packages = [
    pkgs.nixGLDefault.nixGLMesa
  ];
}
