{config, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig =
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
        }
      '';
  };
}
