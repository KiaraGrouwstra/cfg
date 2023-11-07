{ ... }:

{

  services.xserver.enable = true;
  services.xserver.displayManager = {
    lightdm = {
      enable = true;
      greeters.slick.enable = true;
      extraConfig = ''
        logind-check-graphical=true
      '';
    };
  };

}
