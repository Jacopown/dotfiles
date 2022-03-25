local cmd = vim.cmd
local options = {

    -- General --

	backspace = 'indent,eol,start',         -- Without this	on some times backspace did not work correctly.
    backup = false,                         -- Enable backup file creation.
	clipboard = 'unnamedplus',              -- Enables neovim to access the system clipboard.
    cmdheight = 2,                          -- Sets height of command line.
    completeopt = {'menuone', 'noselect'},  -- Settings for cmd autocompletion menu.
    conceallevel = 0,                       -- For better readability in markdown.
	cursorline = false,                      -- Enable cursor line.
	errorbells = true,						-- Enable bell on error.
    fileencoding = 'utf-8',                 -- The file encoding.
    -- guifont = '',                           -- Still not choosen.
	hidden = true,                          -- You’re telling Neovim that you can have unsaved worked that’s not displayed on your screen
	magic = true,							-- Regex now works better
	mouse = 'a',                            -- Enable mouse in all modes.
    pumheight = 10,                         -- Pop Up menu height.
    scrolloff = 8,                          -- Number of lines always on top and bottom of the cursor when scrolling.
	showmatch = false,		                -- When closing a bracket nvim shows for a moment his opening bracket.
    showmode = false,                       -- Enable showing in the bottom left, the current mode.
    sidescrolloff = 8,                      -- Same as scrolloff for lateral scrolling.
    signcolumn = 'yes',                     -- Enable a column, to the left of line numbers, for signs.
    splitbelow = true,                      -- Force all horizontal splits to go below current window.
    splitright = true,                      -- Force all vertical splits to go to the right of current window.
    swapfile = false,                       -- Enable swap file.
	termguicolors = true,                   -- Enables 24-bit RGB color in the TUI
	title = false,							-- Enable title
    timeoutlen = 1000,                      -- Milliseconds to wait for a mapped sequence to complete.
    undofile = true,                        -- Enable persistent undo.
    updatetime = 300,                       -- Faster completion.
	visualbell = true,						-- Use visual bell instead of beeping
    wrap = true,                           -- Enable too long lines to go newline  instead of going outside the view.
    writebackup = false,                    -- Enable backup file before overwriting a file.

    -- Numbers --

	number = true,                          -- Enable line numbers
	numberwidth = 4,                        -- Sets width of line numbers section
	relativenumber = false,                 -- Enable numbers to count up and down from the current line and not from the beginning
	ruler = false,                          -- Enable display of line and column

    -- Indent --

	autoindent = true,                      -- Use same indenting on new lines
	expandtab = true,                       -- Enable conversion of tabs to spaces.
	shiftround = true,                      -- Round indent to multiple of 'shiftwidth'
    shiftwidth = 4,                         -- Number of spaces for each indentation.
	smartindent = true,                     -- Enabel smart autoindenting.
	smarttab = true,
    softtabstop = 4,
	tabstop = 4,                            -- Number of spaces a tab.
	textwidth = 80,                         -- Text width maximum chars before wrapping.

    -- Search --

	hlsearch = true,						-- Enable search highlight.
	ignorecase = true,						-- Enable search case insensitive.
	incsearch = false,						-- Enable incremental search.
    smartcase = true,                       -- Override the 'ignorecase' option if searching with an uppercase character.

}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Commands --
cmd 'set iskeyword+=-'                      -- Now words connected with '-' are considered as a single word.
cmd 'set whichwrap +=<,>,[,],h,l'           -- Now moving left or right at the end of a line moves you up and down.
