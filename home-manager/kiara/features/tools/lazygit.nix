{config, ...}: {
  home.persistence."/persist/home/kiara" = {
    files = [
      ".local/state/lazygit/state.yml"
    ];
  };
  programs.lazygit = {
    enable = true;
    settings = with config.commands; {
      "gui" = {
        "windowSize" = "normal";
        "scrollHeight" = 2;
        "scrollPastBottom" = true;
        "scrollOffMargin" = 2;
        "scrollOffBehavior" = "margin";
        "sidePanelWidth" = 0.3333;
        "expandFocusedSidePanel" = false;
        "mainPanelSplitMode" = "flexible";
        "enlargedSideViewLocation" = "left";
        "language" = "auto";
        "timeFormat" = "02 Jan 06";
        "shortTimeFormat" = "3:04PM";
        "theme" = {
          "activeBorderColor" = [
            "green"
            "bold"
          ];
          "inactiveBorderColor" = [
            "white"
          ];
          "searchingActiveBorderColor" = [
            "cyan"
            "bold"
          ];
          "optionsTextColor" = [
            "blue"
          ];
          "selectedLineBgColor" = [
            "blue"
          ];
          "cherryPickedCommitBgColor" = [
            "cyan"
          ];
          "cherryPickedCommitFgColor" = [
            "blue"
          ];
          "unstagedChangesColor" = [
            "red"
          ];
          "defaultFgColor" = [
            "default"
          ];
        };
        "commitLength" = {
          "show" = true;
        };
        "mouseEvents" = true;
        "skipDiscardChangeWarning" = true;
        "skipStashWarning" = true;
        "showFileTree" = true;
        "showListFooter" = true;
        "showRandomTip" = false;
        "showBranchCommitHash" = true;
        "showBottomLine" = true;
        "showPanelJumps" = true;
        "showCommandLog" = true;
        "nerdFontsVersion" = "3";
        "showFileIcons" = true;
        "commandLogSize" = 8;
        "splitDiff" = "auto";
        "skipRewordInEditorWarning" = true;
        "border" = "rounded";
        "animateExplosion" = true;
        "portraitMode" = "auto";
        "filterMode" = "substring";
        "spinner" = {
          "frames" = [
            "|"
            "/"
            "-"
            "\\\\"
          ];
          "rate" = 50;
        };
        "statusPanelView" = "dashboard";
      };
      "git" = {
        "paging" = {
          "colorArg" = "always";
          "useConfig" = true;
        };
        "commit" = {
          "signOff" = false;
          "autoWrapCommitMessage" = true;
          "autoWrapWidth" = 72;
        };
        "merging" = {
          "manualCommit" = false;
          "args" = "";
        };
        "log" = {
          "order" = "topo-order";
          "showGraph" = "always";
          "showWholeGraph" = false;
        };
        "skipHookPrefix" = "WIP";
        "mainBranches" = [
          "main"
          "master"
        ];
        "autoFetch" = true;
        "autoRefresh" = true;
        "fetchAll" = true;
        "branchLogCmd" = "${git} log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --";
        "allBranchesLogCmd" = "${git} log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium";
        "overrideGpg" = false;
        "disableForcePushing" = false;
        "parseEmoji" = false;
        "truncateCopiedCommitHashesTo" = 12;
      };
      "os" = {
        "copyToClipboardCmd" = "";
        "editPreset" = "";
        "edit" = "";
        "editAtLine" = "";
        "editAtLineAndWait" = "";
        "open" = "${xdg-open} {{filename}} >/dev/null";
        "openLink" = "";
      };
      "refresher" = {
        "refreshInterval" = 10;
        "fetchInterval" = 60;
      };
      "update" = {
        "method" = "prompt";
        "days" = 14;
      };
      "confirmOnQuit" = false;
      "quitOnTopLevelReturn" = false;
      "disableStartupPopups" = true;
      "notARepository" = "prompt";
      "promptToReturnFromSubprocess" = true;
      "keybinding" = with config.keyboard.vi; {
        "universal" = {
          "quit" = "q";
          "quit-alt1" = "<c-c>";
          "return" = "<esc>";
          "quitWithoutChangingDirectory" = "Q";
          "togglePanel" = "<tab>";
          "prevItem" = "<up>";
          "nextItem" = "<down>";
          "prevItem-alt" = k;
          "nextItem-alt" = j;
          "prevPage" = ";";
          "nextPage" = ".";
          "gotoTop" = "<";
          "gotoBottom" = ">";
          "scrollLeft" = H;
          "scrollRight" = L;
          "prevBlock" = "<left>";
          "nextBlock" = "<right>";
          "prevBlock-alt" = h;
          "nextBlock-alt" = l;
          "jumpToBlock" = [
            "1"
            "2"
            "3"
            "4"
            "5"
          ];
          "nextMatch" = n;
          "prevMatch" = N;
          "optionMenu" = "<disabled>";
          "optionMenu-alt1" = "?";
          "select" = "<space>";
          "goInto" = "<enter>";
          "openRecentRepos" = "<c-r>";
          "confirm" = "<enter>";
          "remove" = "d";
          "new" = n;
          "edit" = e;
          "openFile" = o;
          "scrollUpMain" = "<pgup>";
          "scrollDownMain" = "<pgdown>";
          "scrollUpMain-alt1" = K;
          "scrollDownMain-alt1" = J;
          "scrollUpMain-alt2" = "<c-u>";
          "scrollDownMain-alt2" = "<c-d>";
          "executeCustomCommand" = ":";
          "createRebaseOptionsMenu" = "m";
          "pushFiles" = "P";
          "pullFiles" = "p";
          "refresh" = "R";
          "createPatchOptionsMenu" = "<c-p>";
          "nextTab" = "]";
          "prevTab" = "[";
          "nextScreenMode" = "+";
          "prevScreenMode" = "_";
          "undo" = "z";
          "redo" = "<c-z>";
          "filteringMenu" = "<c-s>";
          "diffingMenu" = "W";
          "copyToClipboard" = "<c-o>";
          "submitEditorText" = "<enter>";
          "extrasMenu" = "@";
          "toggleWhitespaceInDiffView" = "<c-w>";
          "increaseContextInDiffView" = "}";
          "decreaseContextInDiffView" = "{";
          "toggleRangeSelect" = "v";
          "rangeSelectUp" = "<s-up>";
          "rangeSelectDown" = "<s-down>";
        };
        "status" = {
          "checkForUpdate" = "u";
          "recentRepos" = "<enter>";
        };
        "files" = {
          "commitChanges" = "c";
          "commitChangesWithoutHook" = "w";
          "amendLastCommit" = "A";
          "commitChangesWithEditor" = "C";
          "findBaseCommitForFixup" = "<c-f>";
          "confirmDiscard" = "x";
          "ignoreFile" = "i";
          "refreshFiles" = "r";
          "stashAllChanges" = "s";
          "viewStashOptions" = "S";
          "toggleStagedAll" = "a";
          "viewResetOptions" = "D";
          "fetch" = "f";
          "toggleTreeView" = "`";
          "openMergeTool" = "M";
          "openStatusFilter" = "<c-b>";
        };
        "branches" = {
          "createPullRequest" = o;
          "viewPullRequestOptions" = O;
          "checkoutBranchByName" = "c";
          "forceCheckoutBranch" = "F";
          "rebaseBranch" = "r";
          "renameBranch" = "R";
          "mergeIntoCurrentBranch" = "M";
          "viewGitFlowOptions" = "i";
          "fastForward" = "f";
          "createTag" = "T";
          "pushTag" = "P";
          "setUpstream" = "u";
          "fetchRemote" = "f";
        };
        "commits" = {
          "squashDown" = "s";
          "renameCommit" = "r";
          "renameCommitWithEditor" = "R";
          "viewResetOptions" = "g";
          "markCommitAsFixup" = "f";
          "createFixupCommit" = "F";
          "squashAboveCommits" = "S";
          "moveDownCommit" = "<c-${j}>";
          "moveUpCommit" = "<c-${k}>";
          "amendToCommit" = "A";
          # "amendAttributeMenu" = "a";
          "pickCommit" = "p";
          "revertCommit" = "t";
          "cherryPickCopy" = "C";
          "pasteCommits" = "V";
          "tagCommit" = "T";
          "checkoutCommit" = "<space>";
          "resetCherryPick" = "<c-R>";
          # "copyCommitMessageToClipboard" = "<c-${y}>";
          "openLogMenu" = "<c-l>";
          "viewBisectOptions" = "b";
        };
        "stash" = {
          "popStash" = "g";
          "renameStash" = "r";
        };
        "commitFiles" = {
          "checkoutCommitFile" = "c";
        };
        "main" = {
          "toggleSelectHunk" = "a";
          "pickBothHunks" = "b";
        };
        "submodules" = {
          "init" = "i";
          "update" = "u";
          "bulkMenu" = "b";
        };
        "commitMessage" = {
          "commitMenu" = "<c-${o}>";
        };
        "amendAttribute" = {
          "addCoAuthor" = "c";
          "resetAuthor" = "a";
          "setAuthor" = "A";
        };
      };
    };
  };
}
