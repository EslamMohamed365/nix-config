{ pkgs, ... }:

let
  langServers = with pkgs; [
    nil # nix
    pyright # python
    yaml-language-server # yaml
    dockerfile-language-server # dockerfile
    taplo # toml
    lua-language-server # lua
  ];

  treesitterGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
    nix python yaml dockerfile toml lua
  ]);

  initLua = ''
    vim.g.mapleader = " "

    local opt = vim.opt
    opt.number = true
    opt.relativenumber = true
    opt.mouse = "a"
    opt.clipboard = "unnamedplus"
    opt.termguicolors = true
    opt.signcolumn = "yes"
    opt.updatetime = 250
    opt.undofile = true
    opt.ignorecase = true
    opt.smartcase = true
    opt.splitright = true
    opt.splitbelow = true
    opt.scrolloff = 8
    opt.completeopt = "menu,menuone,noselect"

    local map = vim.keymap.set
    map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
    map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
    map("n", "<Esc>", "<cmd>nohlsearch<cr>")
    map("n", "<C-h>", "<C-w>h")
    map("n", "<C-j>", "<C-w>j")
    map("n", "<C-k>", "<C-w>k")
    map("n", "<C-l>", "<C-w>l")
    map("n", "<S-h>", "<cmd>tabprevious<cr>")
    map("n", "<S-l>", "<cmd>tabnext<cr>")
    map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "Files" })
    map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buf" })
    map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buf" })

    -- LSP
    vim.lsp.enable({ "nil_ls", "pyright", "yamlls", "dockerls", "taplo", "lua_ls" })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local b = { buffer = args.buf }
        map("n", "gd", vim.lsp.buf.definition, b)
        map("n", "gr", vim.lsp.buf.references, b)
        map("n", "gI", vim.lsp.buf.implementation, b)
        map("n", "K", vim.lsp.buf.hover, b)
        map("n", "<leader>ca", vim.lsp.buf.code_action, b)
        map("n", "<leader>rn", vim.lsp.buf.rename, b)
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, b)
        map("n", "[d", vim.diagnostic.goto_prev, b)
        map("n", "]d", vim.diagnostic.goto_next, b)
      end,
    })

    -- Treesitter
    opt.runtimepath:append("${treesitterGrammars}")
    vim.treesitter.start()
  '';
in
pkgs.symlinkJoin {
  name = "nvim";
  paths = [ pkgs.neovim ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/nvim \
      --add-flags "-u ${pkgs.writeText "init.lua" initLua}" \
      --prefix PATH : ${pkgs.lib.makeBinPath langServers}
  '';
  meta = {
    description = "Minimal productive Neovim for nix/python/yaml/docker/toml/lua";
    mainProgram = "nvim";
  };
}
