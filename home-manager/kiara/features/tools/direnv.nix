{
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/direnv"
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
