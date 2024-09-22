{
  home.persistence."/persist/home/kiara".directories = [
    ".local/share/direnv"
  ];

  home.sessionVariables = {
    # No more long command warnings
    DIRENV_WARN_TIMEOUT = "24h";
    # No more usesless logs
    DIRENV_LOG_FORMAT = "";
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
