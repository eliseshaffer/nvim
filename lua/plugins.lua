local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- ---------------------------------------------------------------------------
  -- UI Plugins
  -- ---------------------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require 'plugins.neotree'
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require 'plugins.telescope'
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function() require 'plugins.lualine' end
  },
  {
    's1n7ax/nvim-window-picker',
    version = 'v2.*',
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
  },
  {
    "folke/which-key.nvim",
  },
  { "petertriho/nvim-scrollbar", config = function() require("scrollbar").setup() end },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = false,
      }
    end
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function() require 'plugins.ufo' end
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("plugins.statuscol")
    end
  },
  {
    'goolord/alpha-nvim',
    config = function()
      require('plugins.alpha')
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require 'plugins.gitsigns' end
  },
  { 'nanozuki/tabby.nvim',       config = function() require('plugins.tabby') end },
  { 'sickill/vim-pasta' },
  { 'karb94/neoscroll.nvim',     config = function() require('neoscroll').setup() end },
  { 'ryanoasis/vim-devicons' },

  -- ---------------------------------------------------------------------------
  -- Colorschemes
  -- ---------------------------------------------------------------------------
  'eliseshaffer/vim-one',
  'folke/tokyonight.nvim',
  { 'marko-cerovac/material.nvim', config = function() require 'plugins.material' end },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require 'plugins.catppuccin'
    end
  },
  {
    'eliseshaffer/darklight.nvim',
    config = function()
      require('darklight').setup()
    end
  },

  -- ---------------------------------------------------------------------------
  -- Git Tools
  -- ---------------------------------------------------------------------------
  {
    'TimUntersberger/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require 'plugins.neogit' end
  },
  { 'sindrets/diffview.nvim',      dependencies = 'nvim-lua/plenary.nvim' },
  'knsh14/vim-github-link',

  -- ---------------------------------------------------------------------------
  -- Language Tools
  -- ---------------------------------------------------------------------------
  { 'sheerun/vim-polyglot' },
  { 'jlcrochet/vim-rbs' },
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require 'plugins.treesitter' end
  },
  {
    url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')

      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  },
  { 'neovim/nvim-lspconfig' },
  -- { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
  -- { 'alexaandru/nvim-lspupdate' },
  -- -- { 'hrsh7th/nvim-cmp',               config = function() require 'plugins.nvim-cmp' end },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets"
    },
    config = function()
      vim.cmd [[
        " press <Tab> to expand or jump in a snippet. These can also be mapped separately
        " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
        imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
        " -1 for jumping backwards.
        inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

        snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
        snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

        " For changing choices in choiceNodes (not strictly necessary for a basic setup).
        imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
        smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
      ]]
    end
  },
  -- -- { 'saadparwaiz1/cmp_luasnip' },
  -- { 'hrsh7th/cmp-nvim-lsp' },
  -- { 'rafamadriz/friendly-snippets' },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },

  -- ---------------------------------------------------------------------------
  -- Misc. Utilities
  -- ---------------------------------------------------------------------------
  {
    "gnikdroy/projections.nvim",
    branch = "pre_release",
    config = function()
      require("projections").setup({
        workspaces = {
          { "~/code",        { ".git" } },
          { "~/code/redcanary",        { ".git" } },
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
  },
  {
    'vim-test/vim-test',
    config = function()
      require 'plugins.vim-test'
    end
  },
  { "pocco81/auto-save.nvim" },
  { 'ur4ltz/move.nvim' },
  { 'preservim/nerdcommenter' },
  { 'preservim/vim-pencil' },
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup()
    end
  },
  { 'mattn/emmet-vim' },
}

local opts = {
  install = {
    colorscheme = { "catppuccin-macchiato" },
  },
}

require("lazy").setup(plugins, opts)
