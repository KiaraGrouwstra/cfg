{ ... }:

{
  programs.git = {

    enable = true;
    userName  = "Kiara Grouwstra";
    userEmail = "kiara@bij1.org";
    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
    };

    ignores = [
      # Compiled source #
      ###################
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"

      # Temporary files #
      ###################
      "*.swp"
      "*.swo"
      "*~"

      # Packages #
      ############
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"

      # Logs #
      ######################
      "*.log"

      # OS generated files #
      ######################
      ".DS_Store*"
      "ehthumbs.db"
      "Icon?"
      "Thumbs.db"

      # Editor files #
      ################
      ".vscode"
    ];

    extraConfig = {
      push.autoSetupRemote = true;
      branch.autoSetupMerge = "simple";
    };

  };
}
