-- -------------------------------------------------------------------------------------------
--
-- Plugins
--
-- -------------------------------------------------------------------------------------------
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
end

-- vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('packer').init({ max_jobs = 10 })

require('packer').startup(function(use)
  -- manage Packer itself
  use { 'wbthomason/packer.nvim' }

  -- File Management
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require 'plugins.neotree'
    end
  }
  use { 'nvim-lua/plenary.nvim' } -- Required for telescope
  use { 'nvim-telescope/telescope.nvim', config = function() require 'plugins.telescope' end }

  -- LSP
  use { 'neovim/nvim-lspconfig' }
  use { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' }
  use { 'alexaandru/nvim-lspupdate' }

  -- Autocomplete / Snippets
  use { 'hrsh7th/nvim-cmp', config = function() require 'plugins.nvim-cmp' end }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'rafamadriz/friendly-snippets' }
  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end }

  -- Treesitter / Formatting
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require 'plugins.treesitter' end
  }
  use { 'HiPhish/nvim-ts-rainbow2' }
  use { 'sheerun/vim-polyglot' }
  use { 'jlcrochet/vim-rbs' }
  use { 'preservim/vim-pencil' }

  -- UI
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require 'plugins.lualine' end
  }
  use {
    's1n7ax/nvim-window-picker',
    tag = 'v2.*',
    config = function()
      require('window-picker').setup({
        highlights = {
          statusline = {
            focused = {
              fg = '#303446',
              bg = '#a6d189',
              bold = false,
            },
            unfocused = {
              fg = '#303446',
              bg = '#babbf1',
              bold = false,
            },
          },
        },
      })
    end,
  }
  use {
    "folke/which-key.nvim",
  }
  use { 'sickill/vim-pasta' }
  use { 'karb94/neoscroll.nvim', config = function() require('neoscroll').setup() end }

  -- Icons
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'ryanoasis/vim-devicons' }

  -- Colors
  use { 'eliseshaffer/vim-one' }
  use { 'marko-cerovac/material.nvim', config = function() require 'plugins.material' end }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require 'plugins.catppuccin'
    end
  }
  use 'folke/tokyonight.nvim'
  -- use { '~/code/neovim/darklight.nvim', config = function()
  use { 'eliseshaffer/darklight.nvim', config = function()
    require('darklight').setup()
  end
  }
  use { "petertriho/nvim-scrollbar", config = function() require("scrollbar").setup() end }
  use { "lukas-reineke/indent-blankline.nvim", config = function()
    require("indent_blankline").setup {
      show_current_context = true,
      show_current_context_start = false,
    }
  end
  }

  -- Tools
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = function() require 'plugins.ufo' end }
  use { "luukvbaal/statuscol.nvim", config = function()
    require("plugins.statuscol")
  end
  }
  use { 'vim-test/vim-test', config = function() require 'plugins.vim-test' end }
  use { "pocco81/auto-save.nvim" }
  use { 'ur4ltz/move.nvim' }
  use { 'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require 'plugins.gitsigns' end
  }
  use { 'TimUntersberger/neogit',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require 'plugins.neogit' end
  }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'preservim/nerdcommenter' }
  use { "ellisonleao/glow.nvim", config = function() require("glow").setup() end }
  use { 'mattn/emmet-vim' }
  use { 'knsh14/vim-github-link' }
  use {
    "utilyre/barbecue.nvim",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons",     -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
  }
  use { 'nanozuki/tabby.nvim', config = function() require('plugins.tabby') end }
  -- use { '~/code/neovim/tabline.nvim', config = function() require('tabline').setup() end }

  -- Start Screen
  use { 'goolord/alpha-nvim',
    config = function()
      require 'plugins.alpha'
    end
  }
  use({
    "gnikdroy/projections.nvim",
    branch = "pre_release",
    config = function()
      require("projections").setup({
        workspaces = {
          { "~/code",        { ".git" } },
          { "~/code/neovim", { ".git" } },
        },
      })

      -- Bind <leader>fp to Telescope projections
      require('telescope').load_extension('projections')
      vim.keymap.set("n", "<leader>fp", function() vim.cmd("Telescope projections") end)

      -- Autostore session on VimExit
      local Session = require("projections.session")
      vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
        callback = function() Session.store(vim.loop.cwd()) end,
      })

      vim.api.nvim_create_user_command("SaveProjectSession", function()
        Session.store(vim.loop.cwd())
      end, {})

      vim.api.nvim_create_user_command("RestoreProjectSession", function()
        Session.restore(vim.loop.cwd())
      end, {})
    end
  })
  -- use { 'blaineventurine/sessionable',
  -- config = function()
  -- require("sessionable").setup({
  -- session_dir = "$HOME/.local/share/nvim/session/",
  -- log_level = "debug"
  -- })
  -- end
  -- }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.g.NERDSpaceDelims = 1
require 'luasnip'.filetype_extend("ruby", { "rails" })
