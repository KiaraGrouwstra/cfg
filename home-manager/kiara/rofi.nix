{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    terminal = "wezterm";

    plugins = with pkgs; [
      rofi-vpn
      rofi-mpd
      rofi-menugen
      rofi-systemd
      pinentry-rofi
      rofi-bluetooth
      rofi-power-menu
      rofi-pulse-select
      rofimoji
      rofi-top
      rofi-calc
      rofi-screenshot
      rofi-file-browser
    ];
    xoffset = 50;
    yoffset = 80;
    location = "center";
    extraConfig = {
      modi = "window,run,drun,ssh,combi,keys,filebrowser";
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
    };
    pass = {
      enable = true;
      package = pkgs.rofi-pass-wayland;
      stores = ["~/.password-store/bij1-shared/"];
      extraConfig = ''
        URL_field='url'
        USERNAME_field='user'
        AUTOTYPE_field='autotype'
      '';
    };
  };

  home.packages = with pkgs; [rofi-systemd rofimoji];
}
