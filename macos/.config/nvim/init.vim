" Settings
"
:syntax enable			" Enables syntax highlighting.
:set background=dark		" Switch between dark and light
:set number			" Show line numbers.
:set ruler			" Show the line and column numbers of the cursor in the bottom-right.
:set termguicolors

" Plugins
"
call plug#begin('~/.config/nvim/plugged')
Plug 'morhetz/gruvbox'		" Gruvbox colorscheme
call plug#end()

" Set colorscheme
"
:colorscheme gruvbox

:hi Normal guibg=none 		" removes opaque bg to match with alacritty bg opacity
