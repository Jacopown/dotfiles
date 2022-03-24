-- Automatically install packer

local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}


return packer.startup(function(use)

    use 'wbthomason/packer.nvim'        -- Let's packer manage himself
    use 'morhetz/gruvbox'               -- GruvBox Color Scheme
    use 'kyazdani42/nvim-web-devicons'  -- Icons
    use 'norcalli/nvim-colorizer.lua'   -- Hex code colorizer

    -- File explorer --
    use {'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('plugins/nvim-tree')
        end}

    -- BUFFER LINE --
    use 'moll/vim-bbye'
    use {'akinsho/bufferline.nvim',
        requires = {'kyazdani42/nvim-web-devicons',
                    'moll/vim-bbye',},
    	config = function()
            require('plugins/bufferline')
        end}

    -- Status Line --
    use {'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('plugins/lualine')
        end}

    -- TREESITTER --
    use {'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins/treesitter')
        end}
    use {'p00f/nvim-ts-rainbow',
    requires = 'nvim-treesitter/nvim-treesitter',}  -- Rainbow parentheses

    -- AUTOCOMPLETION --
    use 'hrsh7th/cmp-nvim-lsp'                  -- LSP completions module.
    use 'hrsh7th/cmp-buffer'                    -- Buffer completions module.
    use 'hrsh7th/cmp-path'                      -- Path completions module.
    use 'hrsh7th/cmp-cmdline'                   -- Cmdline completions module.
    use 'saadparwaiz1/cmp_luasnip'              -- Snippet completions module.
    use 'hrsh7th/cmp-nvim-lua'                  -- Lua completions module.
    use {'hrsh7th/nvim-cmp',                    -- Autocompletion plugin.
        requires = {'hrsh7th/cmp-cmdline',
                    'hrsh7th/cmp-buffer',
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-nvim-lsp',
                    'hrsh7th/cmp-nvim-lua'},
        config = function()
            require('plugins/cmp')
        end}

    -- SNIPPETS --
    use 'L3MON4D3/LuaSnip'                      -- Snippet engine.
    use 'rafamadriz/friendly-snippets'          -- A bunch of snippets to use.

    -- LSP --
    use 'neovim/nvim-lspconfig'                 -- Enable LSP.
    use 'williamboman/nvim-lsp-installer'       -- Simple to use language server installer.

    -- AUTOPAIRS --
    use {'windwp/nvim-autopairs',
        config = function ()
            require('plugins/autopairs')
        end}

    -- COMMENTS --
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use {'numToStr/Comment.nvim',
        requires = 'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require('plugins/comments')
        end}

    -- GIT SIGNS --
    use {'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'},
        config = function ()
            require("plugins/gitsigns")
        end}

    -- TELESCOPE --
    use 'nvim-lua/plenary.nvim'                         -- Required by Telescope.
    use {'nvim-telescope/telescope-fzf-native.nvim',    -- Telescope sorter.
        run = 'make',}
    use  'nvim-telescope/telescope-file-browser.nvim'
    use {'nvim-telescope/telescope.nvim',               -- Telescopoe plugin.
        requires = {'nvim-lua/plenary.nvim',
                    'nvim-telescope/telescope-fzf-native.nvim',
                    'nvim-telescope/telescope-file-browser.nvim',},
        config = function ()
            require('plugins/telescope')
        end}

    -- STURT UP --
    use {'goolord/alpha-nvim',
        config = function ()
            require('plugins/alpha')
        end}

    -- TOGGLE TERM --
    use {"akinsho/toggleterm.nvim",
        config = function ()
            require('plugins/toggleterm')
        end}       -- Nice terminal in NeoVim

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
