return {
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
    require('luasnip.loaders.from_vscode').load_standalone({ path = "./snippets/railstest.code-snippets" })
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
}
