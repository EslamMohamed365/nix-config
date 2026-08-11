{ inputs, ... }: {
  imports = [ inputs.nvf.nixosModules.default ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      # Built-in IDE features
      statusline.lualine.enable = true;
      telescope.enable = true; # Fuzzy finder
      autocomplete.nvim-cmp.enable = true; # Autocompletion
      filetree.neo-tree.enable = true; # File explorer
      
      # Language Servers & Treesitter
      languages = {
        enableLSP = true;
        enableTreesitter = true;
        
        # Turn on languages you use:
        nix.enable = true;
        ts.enable = true;    # TypeScript/JS
        python.enable = true;
        rust.enable = true;
      };
    };
  };
}
