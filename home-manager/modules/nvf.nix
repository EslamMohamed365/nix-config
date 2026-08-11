{ inputs, ... }: {
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      # Built-in IDE features
      statusline.lualine.enable = true;
      telescope.enable = true; # Fuzzy finder
      autocomplete.nvim-cmp.enable = true; # Autocompletion
      filetree.neo-tree.enable = true; # File explorer
      binds.whichKey.enable = true; # Keybinding hints

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
      };
    };
  };
}
