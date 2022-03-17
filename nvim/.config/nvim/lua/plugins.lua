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

    -- Let's packer manage himself
    use 'wbthomason/packer.nvim'

    -- GruvBox Color Scheme --
    use 'morhetz/gruvbox'

    -- Icons --
    use 'kyazdani42/nvim-web-devicons'

    -- File explorer tree --
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = {'NvimTreeOpen', 'NvimTreeToggle'},
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('plugins/nvim-tree')
        end}

    -- Buffer Line --
    use {'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
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
    use 'p00f/nvim-ts-rainbow'                  -- Rainbow parentheses

    -- AUTOCOMPLETION --
    use 'hrsh7th/cmp-cmdline'                   -- Cmdline completions module.
    use 'hrsh7th/cmp-buffer'                    -- Buffer completions module.
    use 'hrsh7th/cmp-path'                      -- Path completions module.
    use 'saadparwaiz1/cmp_luasnip'              -- Snippet completions module.
    use 'hrsh7th/cmp-nvim-lsp'                  -- LSP completions module.
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

    -- STURTUP --
    use {'goolord/alpha-nvim',
        config = function ()
            require('plugins/alpha')
        end}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
