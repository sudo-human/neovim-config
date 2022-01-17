local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
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
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons"
  use "lewis6991/impatient.nvim"
  use {
    "kyazdani42/nvim-tree.lua",
    config = function() require"ps.nvim-tree" end
  }
  use {
    "akinsho/bufferline.nvim",
    config = function ()
      require "ps.bufferline"
    end
  }

  use {
    "folke/which-key.nvim",
  }
  use {
    "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
    config = function ()
      vim.g.cursorhold_updatetime = 100
    end
  }

  -- Themes
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })

  -- Lualine
  use {
    "nvim-lualine/lualine.nvim",
    config = function ()
      require "ps.lualine"
    end
  }

  -- Complition
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"

  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

  use "L3MON4D3/LuaSnip"
  use "saadparwaiz1/cmp_luasnip"

  -- Toggle Term
  use {
    "akinsho/toggleterm.nvim",
    config = function ()
      require "ps.toggleterm"
    end
  }
  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
  }
  use {"nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  -- use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function ()
      require"ps.treesitter"
    end
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    config = function ()
      require "ps.gitsigns"
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
