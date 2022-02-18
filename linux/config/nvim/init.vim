"Auto-Install Vim-Plug

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins

call plug#begin('~/.config/nvim/plugins')
    Plug 'morhetz/gruvbox'              " Gruvbox theme
    Plug 'nvim-lualine/lualine.nvim'    " Status line plugin
    Plug 'ryanoasis/vim-devicons'       " Allows icons
    Plug 'mhinz/vim-startify'           " Start screen plugin
call plug#end()

" Options

set showmatch		        " Show matching
set ignorecase		        " Case insensitive
set hlsearch		        " Highlight search
set incsearch		        " Incremental search
set tabstop=4	        	" Number of colums occupied by a tab
set softtabstop=4	        " See multiple spaces as tabstops
set smarttab
set expandtab		        " Converts tabs to white spaces
set shiftwidth=4	        " width for autoindents
set autoindent 		        " Indent new line the same amount as the line just typed
set number		            " Add line numbers
set termguicolors
set ruler                   " Show the line and column number of cursor in the bottom-right
set wildmenu                " Display all matches when tab complete
syntax on
set clipboard=unnamedplus

" Aesthetics

colorscheme gruvbox         " Set colorscheme
" This allows me to match nvim bg and alacritty bg
highlight Normal guibg=none
" This sets comments to gruvbox blue instead of gray and italic
highlight Comment guifg=#458588 gui=italic 

"LuaLine

lua << END
require('lualine').setup{
  options = {
    theme = 'gruvbox_dark',
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'%F'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
END
