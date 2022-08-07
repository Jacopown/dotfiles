local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print "Installing packer close and reopen Neovim..."
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
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single", border = "rounded" }
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim", commit = "afab89594f4f702dc3368769c95b782dbdaeaf0a" }  -- Have packer manage itself

  -- GUI
  use { "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" } -- Icons
  use { "kyazdani42/nvim-tree.lua", commit = "1685484738377927c4a97a90a4dc031e54c29997",      -- File explorer
    config = function()
      require('plugins/nvim-tree')
    end}
  use { "famiu/bufdelete.nvim", commit = "46255e4a76c4fb450a94885527f5e58a7d96983c" } -- Closing buffers is less a pain in the ass
  use { "akinsho/bufferline.nvim", commit = "21aeb945db6a1c037e42ab6a6f05e357ea623a7b", -- Shows opened buffers
    config = function()
      require('plugins/bufferline')
    end}
  use { "nvim-treesitter/nvim-treesitter", commit = "4e371452e0100989f3489eac8cd20b336ebd403b",
    run = ':TSUpdate',
    config = function()
      require('plugins/treesitter')
    end}
  use { "windwp/nvim-autopairs", commit = "cc8f7569cc1e1b31e50b3c8e382bc2749cbfb2fa",
    config = function()
      require('plugins/autopairs')
    end}
  use { "nvim-lualine/lualine.nvim", commit = "f50ce0f9f69ce4db1d1efa8c7f7f44d90bb7916a",
    config = function()
      require('plugins/lualine')
    end}
  use { 'lewis6991/gitsigns.nvim', commit = "9c3ca027661136a618c82275427746e481c84a4e",
    config = function()
      require('plugins/gitsigns')
    end}
  use { 'goolord/alpha-nvim', commit = "d688f46090a582be8f9d7b70b4cf999b780e993d",
    config = function ()
        require('plugins/alpha')
    end}
  use {'nvim-telescope/telescope-fzf-native.nvim', commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6",
    run = 'make' }
  use { 'nvim-lua/plenary.nvim', commit = "31807eef4ed574854b8a53ae40ea3292033a78ea" }
  use { 'nvim-telescope/telescope.nvim', commit = "4725867ec66b9a0f5e5ad95a1fd94c2f97fa2d2c",
    config = function ()
        require('plugins/telescope')
    end}
  use { "akinsho/toggleterm.nvim", commit = "53c9d50add7c0afd563ed7a6e221422a693f625b",
    config = function()
      require('plugins/toggleterm')
    end}
  use { "lukas-reineke/indent-blankline.nvim", commit = 'c15bbe9f23d88b5c0b4ca45a446e01a0a3913707',
    config = function()
      require('plugins/indentline')
    end}
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = '7d0b001cd6ec2adc25b8d81496c5ef3bd188f781' }
  use { "numToStr/Comment.nvim", commit = '9b76787e273567c0e3027304bd16ffedc751c04c',
    config = function()
      require('plugins/comment')
    end}

  -- cmp plugins
  use { "hrsh7th/cmp-nvim-lsp", commit = 'affe808a5c56b71630f17aa7c38e15c59fd648a8'}
  use { "hrsh7th/cmp-buffer", commit = '62fc67a2b0205136bc3e312664624ba2ab4a9323' } -- buffer completions
  use { "hrsh7th/cmp-path", commit = '447c87cdd6e6d6a1d2488b1d43108bfa217f56e1' } -- path completions
  use { "hrsh7th/cmp-cmdline", commit = '9c0e331fe78cab7ede1c051c065ee2fc3cf9432e' }
  use { "hrsh7th/cmp-nvim-lua", commit = 'd276254e7198ab7d00f117e88e223b4bd8c02d21' }
  use { "kdheepak/cmp-latex-symbols", commit = '46e7627afa8c8ff57158d1c29d721d8efebbc39f' }
  use { "saadparwaiz1/cmp_luasnip", commit = 'a9de941bcbda508d0a45d28ae366bb3f08db2e36' } -- snippet completions 
  use { "hrsh7th/nvim-cmp", commit = '706371f1300e7c0acb98b346f80dad2dd9b5f679', -- The completion plugin
    config = function()
      require('plugins/cmp')
    end}

  -- snippets
  use { "L3MON4D3/LuaSnip", commit = 'ac27343b52796a0aa1bb3db824d16e66d1def182'} --snippet engine
  use { "rafamadriz/friendly-snippets", commit = '7339def34e46237eb7c9a893cb7d42dcb90e05e6' } -- a bunch of snippets to use

  -- lsp
  use { "neovim/nvim-lspconfig" } -- Configurations for Nvim LSP
  use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  use { "RRethy/vim-illuminate",
    config = function()
      require('plugins/illuminate')
    end}
  
  -- Colorschemes
  use { "shaunsingh/nord.nvim", commit = "baf9ab55a8b8a75325ed8a9673e60e4d8fef6092" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
