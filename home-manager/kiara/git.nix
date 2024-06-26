_: {
  home.persistence."/persist/home/kiara".directories = [
    ".config/git"
  ];
  programs.git = {
    enable = true;
    userName = "Kiara Grouwstra";
    userEmail = "kiara.grouwstra@gmail.com";
    diff-so-fancy.enable = true;
    aliases = {
      # commit staged changes to main branch
      main = "!export BRANCH=$(git rev-parse --abbrev-ref HEAD) && git stash --keep-index --include-untracked && git switch main && git commit && git push && git switch $BRANCH && git rebase main && git push --force && git stash pop";
    };

    extraConfig = {
      core.editor = "$EDITOR";
      init.defaultBranch = "main";
      advice.objectNameWarning = false;
      pull.rebase = true;
      push.autoSetupRemote = true;
      branch.autoSetupRebase = "always";
      branch.autoSetupMerge = "simple";
      checkout.defaultRemote = "origin";
      safe.directory = "/tmp"; # needed for ago.sh
    };

    ignores = [
      # Compiled source #
      ###################
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
    ];
  };
}
