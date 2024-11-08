{
  config,
  pkgs,
  ...
}: {
  home.persistence."/persist/home/kiara".directories = [
    ".config/wezterm"
  ];
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = let
      inherit (config.keyboard.vi) j k;
    in
      /*
      lua
      */
      ''
        return {
          hide_tab_bar_if_only_one_tab = true,
          window_close_confirmation = "NeverPrompt",
          enable_kitty_keyboard = true,
          set_environment_variables = {
            TERM = 'wezterm',
          },
          keys = {
            {
               key = '0',
               mods = 'ALT',
               action = wezterm.action.ResetFontSize,
            },
            {
               key = '1',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 0 },
            },
            {
               key = '2',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 1 },
            },
            {
               key = '3',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 2 },
            },
            {
               key = '4',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 3 },
            },
            {
               key = '5',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 4 },
            },
            {
               key = '6',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 5 },
            },
            {
               key = '7',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 6 },
            },
            {
               key = '8',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 7 },
            },
            {
               key = '9',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = -1 },
            },
            {
               key = '0',
               mods = 'ALT',
               action = wezterm.action.ResetFontSize,
            },
            {
               key = '!',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 0 },
            },
            {
               key = '@',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 1 },
            },
            {
               key = '#',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 2 },
            },
            {
               key = '$',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 3 },
            },
            {
               key = '%',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 4 },
            },
            {
               key = '^',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 5 },
            },
            {
               key = '&',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 6 },
            },
            {
               key = '*',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = 7 },
            },
            {
               key = '(',
               mods = 'ALT',
               action = wezterm.action{ActivateTab = -1 },
            },
            {
               key = ')',
               mods = 'ALT',
               action = wezterm.action.ResetFontSize,
            },
            {
               key = '-',
               mods = 'ALT',
               action = wezterm.action.DecreaseFontSize,
            },
            -- {
            --    key = '"',
            --    mods = 'ALT',
            --    action = wezterm.action{SplitVertical = {domain="CurrentPaneDomain"}},
            -- },
            -- {
            --    key = '[',
            --    mods = 'ALT',
            --    action = wezterm.action{ActivateTabRelative = -1 },
            -- },
            -- {
            --    key = ']',
            --    mods = 'ALT',
            --    action = wezterm.action{ActivateTabRelative = 1 },
            -- },
            -- {
            --    key = '%',
            --    mods = 'ALT',
            --    action = wezterm.action{SplitHorizontal = {domain="CurrentPaneDomain"}},
            -- },
            {
               key = '=',
               mods = 'ALT',
               action = wezterm.action.IncreaseFontSize,
            },
            {
               key = 'c',
               mods = 'ALT',
               action = wezterm.action{CopyTo = "Clipboard" },
            },
            -- {
            --    key = 'DownArrow',
            --    mods = 'ALT',
            --    action = wezterm.action{ActivatePaneDirection = "Down" },
            -- },
            -- {
            --    key = 'LeftArrow',
            --    mods = 'ALT',
            --    action = wezterm.action{ActivatePaneDirection = "Left"},
            -- },
            -- {
            --    key = 'RightArrow',
            --    mods = 'ALT',
            --    action = wezterm.action{ActivatePaneDirection = "Right"},
            -- },
            -- {
            --    key = 'UpArrow',
            --    mods = 'ALT',
            --    action = wezterm.action{ActivatePaneDirection = "Up"},
            -- },
            -- {
            --    key = -- 'DownArrow',
            --    mods =--  'ALT|SHIFT',
            --    action--  = wezterm.action{AdjustPaneSize = { "Down", 1 }},
            -- },
            -- {
            --    key = -- 'LeftArrow',
            --    mods =--  'ALT|SHIFT',
            --    action--  = wezterm.action{AdjustPaneSize = {"Left",1}},
            -- },
            -- {
            --    key = -- 'RightArrow',
            --    mods =--  'ALT|SHIFT',
            --    action--  = wezterm.action{AdjustPaneSize = {"Right",1}},
            -- },
            -- {
            --    key = -- 'UpArrow',
            --    mods =--  'ALT|SHIFT',
            --    action--  = wezterm.action{AdjustPaneSize = {"Up",1}},
            -- },
            {
               key = 'g',
               mods = 'ALT',
               action = wezterm.action{Search = {CaseSensitiveString=""}},
            },
            {
               key = '${j}',
               mods = 'ALT',
               action = wezterm.action{ActivateTabRelative = 1 },
            },
            {
               key = '${j}',
               mods = 'CTRL',
               action = wezterm.action{ScrollByPage = 1 },
            },
            {
               key = '${j}',
               mods = 'ALT|SHIFT',
               action = wezterm.action{MoveTabRelative = 1 },
            },
            {
               key = '${k}',
               mods = 'ALT',
               action = wezterm.action{ActivateTabRelative = -1 },
            },
            {
               key = '${k}',
               mods = 'CTRL',
               action = wezterm.action{ScrollByPage = -1 },
            },
            {
               key = '${k}',
               mods = 'ALT|SHIFT',
               action = wezterm.action{MoveTabRelative = -1 },
            },
            -- {
            --    key = 'l',
            --    mods = 'ALT',
            --    action = wezterm.action.ShowDebugOverlay,
            -- },
            -- {
            --    key = 'm',
            --    mods = 'ALT',
            --    action = wezterm.action.Hide,
            -- },
            {
               key = '${
          if config.keyboard.active == "workman"
          then "i"
          else "n"
        }',
               mods = 'ALT',
               action = wezterm.action.SpawnWindow,
            },
            {
               key = 'p',
               mods = 'ALT',
               action = wezterm.action.ActivateCommandPalette,
            },
            -- {
            --    key = 'r',
            --    mods = 'ALT',
            --    action = wezterm.action.ReloadConfiguration,
            -- },
            {
               key = 's',
               mods = 'ALT',
               action = wezterm.action.QuickSelect,
            },
            {
               key = '${
          if config.keyboard.active == "workman"
          then "d"
          else "t"
        }',
               mods = 'ALT',
               action = wezterm.action{SpawnTab = "CurrentPaneDomain"},
            },
            -- {
            --    key = '${
          if config.keyboard.active == "workman"
          then "d"
          else "t"
        }',
            --    mods = 'ALT|SHIFT',
            --    action = wezterm.action{SpawnTab = "DefaultDomain"},
            -- },
            {
               key = 'u',
               mods = 'ALT',
               action = wezterm.action.CharSelect,
            },
            {
               key = 'v',
               mods = 'ALT',
               action = wezterm.action{PasteFrom = "Clipboard"},
            },
            {
               key = 'w',
               mods = 'ALT',
               action = wezterm.action{CloseCurrentTab = {confirm=false}},
            },
            {
               key = 'w',
               mods = 'CTRL|SHIFT',
               action = wezterm.action{CloseCurrentTab = {confirm=false}},
            },
            {
               key = 'x',
               mods = 'ALT',
               action = wezterm.action.ActivateCopyMode,
            },
            -- {
            --    key = 'z',
            --    mods = 'ALT',
            --    action = wezterm.action.TogglePaneZoomState,
            -- },
          },
        }
      '';
  };
}
