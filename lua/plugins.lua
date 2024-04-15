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
  require("plugins.neotree"),
  require("plugins.tableau"),
  require("plugins.telescope"),
  require("plugins.lualine"),
  require("plugins.nvim-window-picker"),
  require("plugins.which-key"),
  require("plugins.barbecue"),
  require("plugins.scrollbar"),
  require("plugins.indent-blankline"),
  require("plugins.nvim-ufo"),
  require("plugins.statuscol"),
  require("plugins.alpha"),
  require("plugins.gitsigns"),
  require("plugins.vim-pasta"),
  require("plugins.neoscroll"),
  { 'ryanoasis/vim-devicons' },

  -- ---------------------------------------------------------------------------
  -- Colorschemes
  -- ---------------------------------------------------------------------------
  'eliseshaffer/vim-one',
  'folke/tokyonight.nvim',
  { 'marko-cerovac/material.nvim', config = function() require 'plugconf.material' end },
  require("plugins.catppuccin"),
  require("plugins.darklight"),

  -- ---------------------------------------------------------------------------
  -- Git Tools
  -- ---------------------------------------------------------------------------
  require("plugins.neogit"),
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
      require('luasnip.loaders.from_vscode').load_standalone({ path = "./snippets/testrails.code-snippets" })
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
  { 'fedepujol/move.nvim' },
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
  dev = {
    path = "~/code/neovim/",
    pattern = "eliseshaffer",
  }
}

require("lazy").setup(plugins, opts)
