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
        servers."yaml-language-server".settings.yaml.schemas.kubernetes = ["*.yaml"];
      };

      diagnostics = {
        enable = true;
        config = {
          virtual_text = true;
          signs = true;
        };
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
        python = {
          enable = true;
          lsp = {
            enable = true;
            servers = ["ruff"];
          };
          format = {
            enable = true;
            type = ["ruff"];
          };
        };
        bash.enable = true;
        lua.enable = true;
        json.enable = true;
        yaml.enable = true;
        markdown = {
          enable = true;
          extensions.render-markdown-nvim.enable = true;
        };
      };

      # ==========================================
      # Full Mini Ecosystem & Clue Setup
      # ==========================================
      mini = {
        ai.enable = true;
        align.enable = true;
        bracketed.enable = true;
        bufremove.enable = true;
        comment.enable = true;
        diff.enable = true;
        extra.enable = true;
        files.enable = true;
        fuzzy.enable = true;
        git.enable = true;
        hipatterns.enable = true;
        icons.enable = true;
        indentscope.enable = true;
        pairs.enable = true;
        pick.enable = true;
        snippets.enable = true;
        splitjoin.enable = true;
        statusline.enable = true;
        surround.enable = true;
        tabline.enable = true;
        trailspace.enable = true;

        clue = {
          enable = true;
          setupOpts = {
            triggers = [
              {
                mode = "n";
                keys = "<Leader>";
              }
              {
                mode = "x";
                keys = "<Leader>";
              }
              {
                mode = "i";
                keys = "<C-x>";
              }
              {
                mode = "n";
                keys = "g";
              }
              {
                mode = "x";
                keys = "g";
              }
              {
                mode = "n";
                keys = "'";
              }
              {
                mode = "n";
                keys = "`";
              }
              {
                mode = "x";
                keys = "'";
              }
              {
                mode = "x";
                keys = "`";
              }
              {
                mode = "n";
                keys = ''"'';
              }
              {
                mode = "x";
                keys = ''"'';
              }
              {
                mode = "i";
                keys = "<C-r>";
              }
              {
                mode = "c";
                keys = "<C-r>";
              }
              {
                mode = "n";
                keys = "<C-w>";
              }
              {
                mode = "n";
                keys = "z";
              }
              {
                mode = "x";
                keys = "z";
              }
              {
                mode = "n";
                keys = "]";
              }
              {
                mode = "n";
                keys = "[";
              }
            ];

            clues = [
              {__raw = "require('mini.clue').gen_clues.builtin_completion()";}
              {__raw = "require('mini.clue').gen_clues.g()";}
              {__raw = "require('mini.clue').gen_clues.marks()";}
              {__raw = "require('mini.clue').gen_clues.registers()";}
              {__raw = "require('mini.clue').gen_clues.windows()";}
              {__raw = "require('mini.clue').gen_clues.z()";}

              {
                mode = "n";
                keys = "<Leader>b";
                desc = "+Buffers";
              }
              {
                mode = "n";
                keys = "<Leader>c";
                desc = "+Code / LSP";
              }
              {
                mode = "n";
                keys = "<Leader>f";
                desc = "+Find (mini.pick)";
              }
              {
                mode = "n";
                keys = "<Leader>w";
                desc = "+Windows / Splits";
              }
              {
                mode = "n";
                keys = "<Leader>x";
                desc = "+Diagnostics (mini.extra)";
              }
            ];

            window = {
              delay = 300;
              config = {
                width = "auto";
                border = "rounded";
              };
            };
          };
        };
      };

      autocomplete.blink-cmp.enable = true;

      treesitter.enable = true;

      utility.undotree.enable = true;

      # ==========================================
      # Keymaps
      # ==========================================
      keymaps = [
        # Buffer Navigation (Shift+h / Shift+l)
        {
          key = "H";
          mode = "n";
          silent = true;
          action = "<cmd>bprevious<CR>";
          desc = "Previous Buffer";
        }
        {
          key = "L";
          mode = "n";
          silent = true;
          action = "<cmd>bnext<CR>";
          desc = "Next Buffer";
        }

        # Window Splits Navigation
        {
          key = "<C-h>";
          mode = "n";
          silent = true;
          action = "<C-w>h";
          desc = "Focus Left Window";
        }
        {
          key = "<C-l>";
          mode = "n";
          silent = true;
          action = "<C-w>l";
          desc = "Focus Right Window";
        }
        {
          key = "<C-j>";
          mode = "n";
          silent = true;
          action = "<C-w>j";
          desc = "Focus Lower Window";
        }
        {
          key = "<C-k>";
          mode = "n";
          silent = true;
          action = "<C-w>k";
          desc = "Focus Upper Window";
        }

        # Window Splitting & Resizing
        {
          key = "<leader>wv";
          mode = "n";
          silent = true;
          action = "<cmd>vsplit<CR>";
          desc = "Split Window Vertically";
        }
        {
          key = "<leader>ws";
          mode = "n";
          silent = true;
          action = "<cmd>split<CR>";
          desc = "Split Window Horizontally";
        }
        {
          key = "<leader>we";
          mode = "n";
          silent = true;
          action = "<C-w>=";
          desc = "Make Splits Equal Size";
        }
        {
          key = "<leader>wd";
          mode = "n";
          silent = true;
          action = "<C-w>c";
          desc = "Close Current Window";
        }

        # Buffer Close (Preserves Split)
        {
          key = "<leader>bd";
          mode = "n";
          silent = true;
          action = "<cmd>lua MiniBufremove.delete()<CR>";
          desc = "Close Buffer (Preserve Split)";
        }

        # Mini.files
        {
          key = "<leader>e";
          mode = "n";
          silent = true;
          action = "<cmd>lua if not MiniFiles.close() then MiniFiles.open() end<CR>";
          desc = "Toggle File Explorer";
        }

        # Mini.pick Searches
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

        # Diagnostics & Symbols (mini.extra)
        {
          key = "<leader>xx";
          mode = "n";
          silent = true;
          action = "<cmd>Pick diagnostic scope='all'<CR>";
          desc = "Workspace Diagnostics";
        }
        {
          key = "<leader>xb";
          mode = "n";
          silent = true;
          action = "<cmd>Pick diagnostic scope='current'<CR>";
          desc = "Buffer Diagnostics";
        }
        {
          key = "<leader>xs";
          mode = "n";
          silent = true;
          action = "<cmd>Pick lsp scope='document_symbol'<CR>";
          desc = "Document Symbols";
        }

        # Trailspace Trim
        {
          key = "<leader>cw";
          mode = "n";
          silent = true;
          action = "<cmd>lua MiniTrailspace.trim()<CR>";
          desc = "Trim Trailing Whitespace";
        }

        # Undotree
        {
          key = "<leader>u";
          mode = "n";
          silent = true;
          action = "<cmd>UndotreeToggle<CR>";
          desc = "Toggle Undotree";
        }

        # LSP Core Actions
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
