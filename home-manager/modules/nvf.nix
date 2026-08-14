{ inputs, ... }: {
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings.vim = {
      mini.move.enable = true;
      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      # --- UI & layout ---
      statusline.lualine.enable = true; # Themed via Stylix by nvf
      tabline.nvimBufferline.enable = true; # Buffer tabs with close/pick/sort
      ui = {
        noice.enable = true; # Pretty cmdline + notifications
        illuminate.enable = true; # Highlight word under cursor
      };

      # --- Fuzzy finder (default binds: <leader>ff/fg/fb/fh/fr) ---
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true; # Autocompletion
      binds = {
        whichKey.enable = true;
        hardtime-nvim.enable = true; # No repeating j/k; forces heading-style motion
      };

      # --- Navigation & editing ---
      navigation.harpoon.enable = true; # <leader>a to mark files, then <C-j/k/l/> to jump
      utility.motion.flash-nvim.enable = true; # s/S for jump-to-anywhere motion
      mini.ai.enable = true; # Text objects: i( i" i[ i{ ...
      mini.indentscope.enable = true; # Indent scope guides

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
      notes.todo-comments.enable = true; # Highlight TODO/FIXME/HACK

      # Language Servers & Treesitter
      lsp = {
        enable = true;
        formatOnSave = true;
        inlayHints.enable = true; # Type hints inline
        lspkind.enable = true; # Icons in completion menu
        lspSignature.enable = true; # Signature help popup
        trouble.enable = true; # <leader>ld / <leader>lwd diagnostics
      };
      languages = {
        enableTreesitter = true;

        # Turn on languages you use:
        nix.enable = true; # Formatted with alejandra on save
        python.enable = true;
        markdown.enable = true;
        bash.enable = true;
        lua.enable = true;
        json.enable = true;
      };
    };
  };
}
