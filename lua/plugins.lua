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
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require 'plugconf.neotree'
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require 'plugconf.telescope'
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function() require 'plugconf.lualine' end
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
  { "folke/which-key.nvim", },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  { "petertriho/nvim-scrollbar",           config = function() require("scrollbar").setup() end },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",                                        opts = {} },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function() require 'plugconf.ufo' end
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("plugconf.statuscol")
    end
  },
  {
    'goolord/alpha-nvim',
    config = function()
      require('plugconf.alpha')
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require 'plugconf.gitsigns' end
  },
  -- { 'nanozuki/tabby.nvim',   config = function() require('plugconf.tabby') end },
  { 'sickill/vim-pasta' },
  { 'karb94/neoscroll.nvim', config = function() require('neoscroll').setup() end },
  { 'ryanoasis/vim-devicons' },

  -- ---------------------------------------------------------------------------
  -- Colorschemes
  -- ---------------------------------------------------------------------------
  'eliseshaffer/vim-one',
  'folke/tokyonight.nvim',
  { 'marko-cerovac/material.nvim', config = function() require 'plugconf.material' end },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require 'plugconf.catppuccin'
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
    config = function() require 'plugconf.neogit' end
  },
  { 'sindrets/diffview.nvim',      dependencies = 'nvim-lua/plenary.nvim' },
  {
    'ldelossa/gh.nvim',
    dependencies = { { 'ldelossa/litee.nvim' } }
  },
  'knsh14/vim-github-link',

  -- ---------------------------------------------------------------------------
  -- Language Tools
  -- ---------------------------------------------------------------------------
  { 'sheerun/vim-polyglot' },
  { 'jlcrochet/vim-rbs' },
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require 'plugconf.treesitter' end
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
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      { "SmiteshP/nvim-navic" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'saadparwaiz1/cmp_luasnip' },
      {
        'L3MON4D3/LuaSnip',
        dependencies =
        { 'rafamadriz/friendly-snippets' },
      }, -- Required
    },
    config = function()
      local lsp = require('lsp-zero').preset({})
      local navic = require('nvim-navic')

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
        if client.server_capabilities.documentSymbolProvider then
          navic.attach(client, bufnr)
        end
      end)

      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
      require('lspconfig').solargraph.setup({})
      require('lspconfig').eslint.setup({})

      lsp.setup()
      -- Make sure you setup `cmp` after lsp-zero

      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local cmp_action = require('lsp-zero').cmp_action()
      local check_backspace = function()
        local col = vim.fn.col "." - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
      end

      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_vscode').load_standalone({ path = "./snippets/erbrails.code-snippets" })
      luasnip.filetype_extend("ruby", { "rails" })

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        mapping = {
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, {
            "i",
            "s",
          }),
        }
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  },
  {
    'Djancyp/better-comments.nvim',
    config = function()
      require('better-comment').Setup()
    end
  },
  'tpope/vim-rails',

  -- ---------------------------------------------------------------------------
  -- Misc. Utilities
  -- ---------------------------------------------------------------------------
  {
    "gnikdroy/projections.nvim",
    branch = "pre_release",
    config = function()
      require("projections").setup({
        workspaces = {
          { "~/code",           { ".git" } },
          { "~/code/redcanary", { ".git" } },
          { "~/code/neovim",    { ".git" } },
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
      require 'plugconf.vim-test'
    end
  },
  { "pocco81/auto-save.nvim", config = function() require("plugconf.autosave") end },
  { 'ur4ltz/move.nvim' },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
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
