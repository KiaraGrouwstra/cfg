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
    // autoStartLinks {
      "firefox" = config.programs.firefox.package;
      "org.wezfurlong.wezterm" = config.programs.wezterm.package;
      "com.nextcloud.desktopclient.nextcloud" = config.services.nextcloud-client.package; 
    }
    // {
      # must `git add .` or new files won't be found
      ".config/swaync/configSchema.json".source = "${pkgs.swaynotificationcenter}/etc/xdg/swaync/configSchema.json";
      ".config/yazi/plugins/mime.yazi".source = "${inputs.yazi-mime}/init.lua";
      ".config/piper/voices".source = "${pkgs.fetchgit {
        url = "https://huggingface.co/rhasspy/piper-voices";
        rev = "c3bf31a7c50ea738281519ca86ba2ee0f50a1882";
        hash = "sha256-8f0CkrML8PgJA04HC+KFJTqdA04mfCM1quEywhXP09M=";
        fetchLFS = true;
      }}";
      ".config/whisper/models".source = "${pkgs.fetchgit {
        url = "https://huggingface.co/ggerganov/whisper.cpp";
        rev = "d15393806e24a74f60827e23e986f0c10750b358";
        hash = "sha256-j1rQXuBMFrNsC3CQ+LFPJf1A/UtHi5pSC8fq4/ted/0=";
        fetchLFS = true;
      }}";
      # https://github.com/nix-community/home-manager/issues/322#issuecomment-1856128020
      ".ssh/config" = {
        source = ./dotfiles/.ssh/config;
        target = ".ssh/config_source";
        onChange = ''cat ~/.ssh/config_source > ~/.ssh/config && chmod 400 ~/.ssh/config'';
      };
    };
}
