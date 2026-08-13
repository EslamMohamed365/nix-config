{ inputs, ... }: {
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings.vim = {
      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
      };
      # Built-in IDE features
      statusline.lualine.enable = true;
      telescope.enable = true; # Fuzzy finder
      autocomplete.nvim-cmp.enable = true; # Autocompletion
      filetree.neo-tree.enable = true; # File explorer
      binds = {
        whichKey.enable = true;
        hardtime-nvim.enable = true;
      };

      # Core editor ergonomics
      undoFile.enable = true; # Persistent undo across restarts
      searchCase = "smart"; # Smart-case search
      globals.mapleader = " "; # Space as leader

      # Essential plugins
      git.enable = true; # Gitsigns: inline diff markers + hunk nav
      snippets.luasnip.enable = true; # Snippet engine (pairs with nvim-cmp)
      autopairs.nvim-autopairs.enable = true; # Auto-close (), [], {}
      comments.comment-nvim.enable = true; # gc to comment lines/blocks
      terminal.toggleterm.enable = true; # Better integrated terminal
      utility.oil-nvim.enable = true; # Modern file manager
      utility.surround.enable = true; # ys/cs/ds to edit surrounding pairs
      ui.noice.enable = true; # Pretty cmdline + notifications

      # Language Servers & Treesitter
      lsp = {
        enable = true;
        formatOnSave = true;
      };
      languages = {
        enableTreesitter = true;

        # Turn on languages you use:
        nix.enable = true;
        tsx.enable = true; # TypeScript/JS
        python.enable = true;
        rust.enable = true;
        markdown.enable = true;
        bash.enable = true;
        lua.enable = true;
        json.enable = true;
      };
    };
  };
}
