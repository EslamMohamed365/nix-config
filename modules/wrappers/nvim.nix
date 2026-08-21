{pkgs, ...}: let
  initVim = ''
    " ========================================
    " Options
    " ========================================

    set encoding=UTF-8
    set nohlsearch
    set number
    set mouse=a
    set breakindent
    set undofile
    set ignorecase
    set smartcase
    set signcolumn=yes
    set updatetime=250
    set timeoutlen=300
    set nobackup
    set nowritebackup
    set completeopt=menuone,noselect
    set whichwrap+=<,>,[,],h,l
    set nowrap
    set linebreak
    set scrolloff=8
    set sidescrolloff=8
    set relativenumber
    set numberwidth=4
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set expandtab
    set nocursorline
    set splitbelow
    set splitright
    set noswapfile
    set smartindent
    set showtabline=2
    set backspace=indent,eol,start
    set pumheight=10
    set conceallevel=0
    set fileencoding=utf-8
    set cmdheight=1
    set autoindent
    set shortmess+=c
    set iskeyword+=-
    set showmatch
    set laststatus=2
    set statusline=%f
    set statusline+=%=
    set statusline+=%l
    set statusline+=/
    set statusline+=%L

    " ========================================
    " Keymaps
    " ========================================

    let mapleader = " "
    let maplocalleader = " "

    nnoremap <Space> <Nop>
    vnoremap <Space> <Nop>

    nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
    nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

    nnoremap <Esc> :noh<CR>

    nnoremap <C-s> :w<CR>
    nnoremap <leader>sn :noautocmd w<CR>
    nnoremap <C-q> :q<CR>

    nnoremap x "_x

    nnoremap <C-d> <C-d>zz
    nnoremap <C-u> <C-u>zz

    nnoremap n nzzzv
    nnoremap N Nzzzv

    nnoremap <Up> :resize -2<CR>
    nnoremap <Down> :resize +2<CR>
    nnoremap <Left> :vertical resize -2<CR>
    nnoremap <Right> :vertical resize +2<CR>

    nnoremap <Tab> :bnext<CR>
    nnoremap <S-Tab> :bprevious<CR>
    nnoremap <leader>sb :buffers<CR>:buffer<Space>

    nnoremap <leader>+ <C-a>
    nnoremap <leader>- <C-x>

    nnoremap <leader>v <C-w>v
    nnoremap <leader>h <C-w>s
    nnoremap <leader>se <C-w>=
    nnoremap <leader>xs :close<CR>

    nnoremap <C-k> :wincmd k<CR>
    nnoremap <C-j> :wincmd j<CR>
    nnoremap <C-h> :wincmd h<CR>
    nnoremap <C-l> :wincmd l<CR>

    nnoremap <leader>to :tabnew<CR>
    nnoremap <leader>tx :tabclose<CR>
    nnoremap <leader>tn :tabn<CR>
    nnoremap <leader>tp :tabp<CR>

    nnoremap <leader>x :bdelete<CR>
    nnoremap <leader>b :enew<CR>

    nnoremap <leader>lw :set wrap!<CR>

    inoremap jk <ESC>
    inoremap kj <ESC>

    " Completion popup: Tab/S-Tab cycle, Enter accepts without newline
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

    vnoremap p "_dP

    noremap <leader>y "+y
    noremap <leader>Y "+Y

    noremap <silent> <leader>e :Lex<CR>

    " ========================================
    " Other
    " ========================================

    syntax on

    " colorscheme industry
    colorscheme habamax
    set background=dark

    if system('uname -s') == "Darwin\n"
      set clipboard=unnamed
    else
      set clipboard=unnamedplus
    endif

    if !has('gui_running') && &term =~ '\%(screen\|tmux\)'
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors

    let &t_SI = "\e[6 q"
    let &t_EI = "\e[2 q"

    " Netrw
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 4
    let g:netrw_altv = 1
    let g:netrw_winsize = 25

    augroup netrw_setup | au!
        au FileType netrw nmap <buffer> l <CR>
    augroup END

    " ========================================
    " LSP - Kubernetes YAML (native, no plugins)
    " ========================================

    lua << EOF
    vim.lsp.config("yaml-language-server", {
      cmd = { "yaml-language-server", "--stdio" },
      filetypes = { "yaml" },
      settings = {
        yaml = {
          schemas = { kubernetes = "*.yaml" },
          schemaStore = { enable = true },
        },
      },
    })
    vim.lsp.enable("yaml-language-server")
    vim.diagnostic.config({ virtual_text = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
      end,
    })
    EOF
  '';
in
  pkgs.symlinkJoin {
    name = "nvim";
    paths = [pkgs.neovim];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --add-flags "-u ${pkgs.writeText "init.vim" initVim}" \
        --prefix PATH : ${pkgs.yaml-language-server}/bin
    '';
    meta = {
      description = "Neovim with custom config";
      mainProgram = "nvim";
    };
  }
