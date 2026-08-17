{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings.vim = {
      viAlias = true;
      vimAlias = true;

      opts.expandtab = true;
      opts.hidden = true;
      undoFile.enable = true;
      searchCase = "smart";

      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        trouble.enable = true;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix = {
          enable = true;
          lsp = {
            enable = true;
            servers = ["nixd"];
          };
          format = {
            enable = true;
            type = ["alejandra"];
          };
        };
        bash.enable = true;
        lua.enable = true;
        json.enable = true;
        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
      };

      mini = {
        move.enable = false;
        pairs.enable = true;
        comment.enable = true;
        indentscope.enable = true;
        statusline.enable = true;
        surround.enable = true;
        files.enable = true;
        pick.enable = true;
        icons.enable = true;
        snippets.enable = true;
      };

      autocomplete = {
        nvim-cmp.enable = false;
        blink-cmp.enable = true;
      };

      treesitter = {
        enable = true;
        context.enable = false;
      };

      binds.whichKey.enable = true;

      utility = {
        undotree.enable = true;
        smart-splits.enable = true;
      };

      # ==========================================
      # Keymaps
      # ==========================================
      keymaps = [
        {
          key = "<C-h>";
          mode = "n";
          silent = true;
          action = "<cmd>bprevious<CR>";
          desc = "Previous Buffer";
        }
        {
          key = "<C-l>";
          mode = "n";
          silent = true;
          action = "<cmd>bnext<CR>";
          desc = "Next Buffer";
        }
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = "<cmd>lua if not MiniFiles.close() then MiniFiles.open() end<CR>";
          desc = "Toggle File Explorer";
        }
        {
          key = "<leader>ff";
          mode = "n";
          silent = true;
          action = "<cmd>Pick files<CR>";
          desc = "Find Files";
        }
        {
          key = "<leader>fg";
          mode = "n";
          silent = true;
          action = "<cmd>Pick grep_live<CR>";
          desc = "Live Grep (Search Text)";
        }
        {
          key = "<leader>fb";
          mode = "n";
          silent = true;
          action = "<cmd>Pick buffers<CR>";
          desc = "Find Open Buffers";
        }
        {
          key = "<leader>fh";
          mode = "n";
          silent = true;
          action = "<cmd>Pick help<CR>";
          desc = "Find Help Tags";
        }

        {
          key = "<leader>u";
          mode = "n";
          silent = true;
          action = "<cmd>UndotreeToggle<CR>";
          desc = "Toggle Undotree";
        }

        {
          key = "<leader>xx";
          mode = "n";
          silent = true;
          action = "<cmd>Trouble diagnostics toggle<CR>";
          desc = "Project Diagnostics (Trouble)";
        }
        {
          key = "<leader>xb";
          mode = "n";
          silent = true;
          action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
          desc = "Buffer Diagnostics (Trouble)";
        }
        {
          key = "<leader>xs";
          mode = "n";
          silent = true;
          action = "<cmd>Trouble symbols toggle<CR>";
          desc = "Buffer Symbols (Trouble)";
        }

        {
          key = "<leader>cr";
          mode = "n";
          silent = true;
          action = "<cmd>lua vim.lsp.buf.rename()<CR>";
          desc = "LSP Rename Variable";
        }
        {
          key = "<leader>ca";
          mode = ["n" "v"];
          silent = true;
          action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
          desc = "LSP Code Action";
        }
      ];
    };
  };
}
