{ lib, pkgs, ... }:

{

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
      chadtree
      nvim-treesitter.withAllGrammars
      coc-fzf
      coc-prettier
      coc-snippets
      coc-explorer
      coc-stylelint
      coc-highlight
      coc-diagnostic
      coc-spell-checker
      coc-markdownlint
      coc-sh
      coc-go
      coc-git
      coc-rls
      coc-css
      coc-toml
      coc-nvim
      coc-java
      coc-json
      coc-html
      coc-yaml
      coc-metals
      coc-texlab
      coc-python
      coc-smartf
      coc-eslint
      coc-docker
      coc-vimlsp
      coc-tslint
      coc-vimtex
      coc-pyright
      coc-tsserver
      coc-solargraph
      coc-tslint-plugin
      coc-rust-analyzer
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
