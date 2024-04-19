{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  autoStartLinks = lib.mapAttrs' (desktopName: package:
    lib.nameValuePair ".config/autostart/${desktopName}.desktop" {
      source = "${package}/share/applications/${desktopName}.desktop";
    });
in {
  home.file =
    (lib.homeFolder ./dotfiles)
    # keys: ls ~/.local/share/applications/
    # vals: ls ~/.nix-profile/bin/
    // autoStartLinks (with pkgs; {
      "org.keepassxc.KeePassXC" = keepassxc;
      # "codium" = config.programs.vscode.package;
      "firefox" = config.programs.firefox.package;
      # "com.nextcloud.desktopclient.nextcloud" = nextcloud-client;
      "org.wezfurlong.wezterm" = config.programs.wezterm.package;
    })
    // {
      # must `git add .` or new files won't be found
      ".config/swaync/configSchema.json".source = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
      ".config/yazi/plugins/mime.yazi".source = "${inputs.yazi-mime}/init.lua";
      # https://github.com/nix-community/home-manager/issues/322#issuecomment-1856128020
      ".ssh/config" = {
        source = ./dotfiles/.ssh/config;
        target = ".ssh/config_source";
        onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
      };
    };
  # ".config/sops/age/keys.txt".source = config.sops.secrets.age-keys.path; # $SOPS_AGE_KEY_FILE # error: attribute 'sops' missing
}
