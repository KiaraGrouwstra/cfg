{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    package = pkgs.wofi.overrideAttrs (oa: {
      patches = (oa.patches or [ ]) ++ [
        ./wofi-run-shell.patch # Fix for https://todo.sr.ht/~scoopta/wofi/174
      ];
    });

    # https://github.com/prtce/wofi
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      show_all = false;
      print_command = true;
      insensitive = true;
      prompt = "Hmm, what do you want to run?";
      gtk_dark = true;
      key_expand = "Tab";

      image_size = 48;
      columns = 3;
      allow_images = true;
      # insensitive = true; # already defined up
      run-always_parse_args = true;
      run-cache_file = "/dev/null";
      run-exec_search = true;
    };

    # https://github.com/prtce/wofi/blob/main/src/frappe/maroon/style.css
    style = ''
      /* Frappe Maroon */
      @define-color accent #ea999c;
      @define-color txt #cad3f5;
      @define-color bg #303446;
      @define-color bg2 #51576d;

      * {
          font-family: ${config.fontProfiles.regular.family};
          font-size: 14px;
      }

      /* Window */
      window {
          margin: 0px;
          padding: 10px;
          border: 3px solid @accent;
          border-radius: 7px;
          background-color: @bg;
          animation: slideIn 0.5s ease-in-out both;
      }

      /* Slide In */
      @keyframes slideIn {
          0% {
            opacity: 0;
          }

          100% {
            opacity: 1;
          }
      }

      /* Inner Box */
      #inner-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
          animation: fadeIn 0.5s ease-in-out both;
      }

      /* Fade In */
      @keyframes fadeIn {
          0% {
            opacity: 0;
          }

          100% {
            opacity: 1;
          }
      }

      /* Outer Box */
      #outer-box {
          margin: 5px;
          padding: 10px;
          border: none;
          background-color: @bg;
      }

      /* Scroll */
      #scroll {
          margin: 0px;
          padding: 10px;
          border: none;
      }

      /* Input */
      #input {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @accent;
          background-color: @bg2;
          animation: fadeIn 0.5s ease-in-out both;
      }

      /* Text */
      #text {
          margin: 5px;
          padding: 10px;
          border: none;
          color: @txt;
          animation: fadeIn 0.5s ease-in-out both;
      }

      /* Selected Entry */
      #entry:selected {
        background-color: @accent;
      }

      #entry:selected #text {
          color: @bg;
      }
    '';

  };

  # home.packages =
  #   let
  #     inherit (config.programs.password-store) package enable;
  #   in
  #   lib.optional enable (pkgs.pass-wofi.override { pass = package; });

}
