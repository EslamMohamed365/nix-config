# Home Manager module replicating `github:notashelf/nvf#maximal`
# (generated from nvf's configuration.nix with isMaximal = true)
{inputs, ...}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings.vim = {
      mini.move.enable = true;
      viAlias = true;
      vimAlias = true;
      clipboard = {
        enable = true;
        registers = "unnamedplus";
        providers.wl-copy.enable = true;
      };
      debugMode = {
        enable = false;
        level = 16;
        logFile = "/tmp/nvim.log";
      };

      # vim.opts and vim.options are aliased
      opts.expandtab = true;

      # codewindow reads its config at module-load (before setup()), so
      # use_treesitter must be disabled *before* `require('codewindow')` runs,
      # otherwise it requires nvim-treesitter.ts_utils, removed upstream.
      luaConfigRC.codewindow-no-treesitter = {
        after = ["lazyConfigs"];
        before = ["pluginConfigs"];
        data = ''
          require("codewindow.config").setup({ use_treesitter = false })
        '';
      };

      lsp = {
        # This must be enabled for the language modules to hook into
        # the LSP API.
        enable = true;

        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        trouble.enable = true;
        lspSignature.enable = false; # conflicts with blink in maximal
        otter-nvim.enable = true;
        nvim-docs-view.enable = true;
        presets.harper.enable = false;
      };
      undoFile.enable = true;
      searchCase = "smart";
      debugger = {
        nvim-dap = {
          enable = true;
          ui.enable = true;
        };
      };

      # This section does not include a comprehensive list of available language modules.
      # To list all available language module options, please visit the nvf manual.
      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        # Languages that will be supported in default and maximal configurations.
        nix.enable = true;
        markdown = {
          enable = true;
          # Inline rendering of headings, lists, code blocks etc. in-buffer.
          extensions.render-markdown-nvim.enable = true;
        };

        # Languages that are enabled in the maximal configuration.
        bash.enable = true;
        clang.enable = false;
        cmake.enable = false;
        css.enable = false;
        scss.enable = false;
        html.enable = false;
        json.enable = true;
        sql.enable = false;
        java.enable = false;
        kotlin.enable = false;
        typescript.enable = false;
        go.enable = false;
        lua.enable = true;
        zig.enable = false;
        python.enable = false;
        typst.enable = false;
        rust = {
          enable = false;
          # Can only be enabled if lsp.enable = false
          extensions.rustaceanvim.enable = false;
          extensions.crates-nvim.enable = true;
        };
        toml.enable = false;
        xml.enable = false;
        tex.enable = false;
        docker.enable = false;
        env.enable = false;

        # Language modules that are not as common.
        arduino.enable = false;
        assembly.enable = false;
        astro.enable = false;
        awk.enable = false;
        beancount.enable = false;
        csharp.enable = false;
        dart.enable = false;
        elixir.enable = false;
        fish.enable = false;
        fluent.enable = false;
        fsharp.enable = false;
        gettext.enable = false;
        gleam.enable = false;
        glsl.enable = false;
        haskell.enable = false;
        hcl.enable = false;
        jinja.enable = false;
        jq.enable = false;
        julia.enable = false;
        just.enable = false;
        liquid.enable = false;
        lisp.enable = false;
        make.enable = false;
        nu.enable = false;
        ocaml.enable = false;
        openscad.enable = false;
        pug.enable = false;
        qml.enable = false;
        r.enable = false;
        ruby.enable = false;
        scala.enable = false;
        standard-ml.enable = false;
        svelte.enable = false;
        tera.enable = false;
        tsx.enable = false;
        twig.enable = false;
        vala.enable = false;
        vue.enable = false;
        zsh.enable = false;

        # Nim LSP is broken on Darwin and therefore
        # should be disabled by default. Users may still enable
        # `vim.languages.nim` to enable it, this does not restrict
        # that.
        # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
        nim.enable = false;
      };

      visuals = {
        nvim-scrollbar.enable = true;
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
        cinnamon-nvim.enable = true;
        fidget-nvim.enable = true;

        highlight-undo.enable = true;
        blink-indent.enable = true;
        indent-blankline.enable = true;

        # Fun
        cellular-automaton.enable = false;
      };

      statusline = {
        lualine = {
          enable = true;
          # theme = "catppuccin";
        };
      };

      # theme = {
      #   enable = true;
      #   name = "catppuccin";
      #   style = "mocha";
      #   transparent = false;
      # };

      autopairs.nvim-autopairs.enable = true;

      # nvf provides various autocomplete options. The tried and tested nvim-cmp
      # is enabled in default package, because it does not trigger a build. We
      # enable blink-cmp in maximal because it needs to build its rust fuzzy
      # matcher library.
      autocomplete = {
        nvim-cmp.enable = false;
        blink-cmp.enable = true;
      };

      snippets.luasnip.enable = true;

      filetree = {
        neo-tree = {
          enable = true;
        };
      };

      tabline = {
        nvimBufferline.enable = true;
      };

      treesitter = {
        enable = true;
        context.enable = true;
      };

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
        hardtime-nvim.enable = true;
      };

      telescope.enable = true;

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false; # throws an annoying debug message
        neogit.enable = true;
      };

      minimap = {
        minimap-vim.enable = false;
        # ponytail: codewindow requires removed nvim-treesitter.ts_utils at
        # module-load when use_treesitter is on; disabled via luaConfigRC
        # above, minimap renders without syntax colors.
        codewindow.enable = true; # lighter, faster, and uses lua for configuration
      };

      dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = true;
      };

      notify = {
        nvim-notify.enable = true;
      };

      projects = {
        project-nvim.enable = true;
      };

      utility = {
        ccc.enable = false;
        vim-wakatime.enable = false;
        diffview-nvim.enable = true;
        yanky-nvim.enable = false;
        qmk-nvim.enable = false; # requires hardware specific options
        icon-picker.enable = true;
        surround.enable = true;
        leetcode-nvim.enable = false;
        multicursors.enable = true;
        smart-splits.enable = true;
        undotree.enable = true;
        nvim-biscuits.enable = true;
        grug-far-nvim.enable = true;

        motion = {
          hop.enable = true;
          leap.enable = true;
          precognition.enable = true;
        };
        images = {
          image-nvim.enable = false;
          img-clip.enable = true;
        };
      };

      notes = {
        neorg.enable = false;
        orgmode.enable = false;
        todo-comments.enable = true;
      };

      terminal = {
        toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };

      ui = {
        borders.enable = true;
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false; # the theme looks terrible with catppuccin
        illuminate.enable = true;
        breadcrumbs = {
          enable = true;
          navbuddy.enable = true;
        };
        smartcolumn = {
          enable = true;
          setupOpts.custom_colorcolumn = {
            # this is a freeform module, it's `buftype = int;` for configuring column position
            nix = "110";
            ruby = "120";
            java = "130";
            go = [
              "90"
              "130"
            ];
          };
        };
        fastaction.enable = true;
      };

      # assistant = {
      #   chatgpt.enable = false;
      #   copilot = {
      #     enable = false;
      #     cmp.enable = true;
      #   };
      #   codecompanion-nvim.enable = false;
      #   avante-nvim.enable = true;
      # };

      session = {
        nvim-session-manager.enable = false;
      };

      gestures = {
        gesture-nvim.enable = false;
      };

      comments = {
        comment-nvim.enable = true;
      };

      presence = {
        neocord.enable = false;
        cord-nvim.enable = false;
      };
    };
  };
}
