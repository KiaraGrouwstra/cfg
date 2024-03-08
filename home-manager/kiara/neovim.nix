{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nodejs # for coc
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      LanguageClient-neovim
      pywal-nvim
      nvchad
      nvchad-ui
      # chadtree
      nvim-treesitter.withAllGrammars # TODO: split up as per https://mynixos.com/nixpkgs/packages/vimPlugins.nvim-treesitter-parsers
      coc-fzf
      coc-prettier
      coc-snippets
      coc-explorer
      coc-stylelint
      coc-highlight
      coc-diagnostic
      coc-spell-checker
      coc-solargraph
      coc-smartf
    ];
    extraConfig = ''
      set number
      set cc=80
      set list
      set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
      """ if &diff
        colorscheme blue
      """ endif

      """ LSP
      let g:LanguageClient_serverCommands = {
        \ 'python': ['pyls']
        \ }
      nnoremap <F5> :call LanguageClient_contextMenu()<CR>
      nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
      nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
      nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
      nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
      nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
      nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

      """ Codium
      if exists('g:vscode')
        set clipboard=unnamedplus
      endif
    '';
  };
}
