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
    -- textDocument/diagnostic support until 0.10.0 is released
    local _timers = {}
    local function setup_diagnostics(client, buffer)
      if require("vim.lsp.diagnostic")._enable then
        return
      end

      local diagnostic_handler = function()
        local params = vim.lsp.util.make_text_document_params(buffer)
        client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
          if err then
            local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
            vim.lsp.log.error(err_msg)
          end
          local diagnostic_items = {}
          if result then
            diagnostic_items = result.items
          end
          vim.lsp.diagnostic.on_publish_diagnostics(
            nil,
            vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
            { client_id = client.id }
          )
        end)
      end

      diagnostic_handler() -- to request diagnostics on buffer when first attaching

      vim.api.nvim_buf_attach(buffer, false, {
        on_lines = function()
          if _timers[buffer] then
            vim.fn.timer_stop(_timers[buffer])
          end
          _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
        end,
        on_detach = function()
          if _timers[buffer] then
            vim.fn.timer_stop(_timers[buffer])
          end
        end,
      })
    end

    -- adds ShowRubyDeps command to show dependencies in the quickfix list.
    -- add the `all` argument to show indirect dependencies as well
    local function add_ruby_deps_command(client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, "ShowRubyDeps",
        function(opts)
          local params = vim.lsp.util.make_text_document_params()

          local showAll = opts.args == "all"

          client.request("rubyLsp/workspace/dependencies", params,
            function(error, result)
              if error then
                print("Error showing deps: " .. error)
                return
              end

              local qf_list = {}
              for _, item in ipairs(result) do
                if showAll or item.dependency then
                  table.insert(qf_list, {
                    text = string.format("%s (%s) - %s",
                      item.name,
                      item.version,
                      item.dependency),

                    filename = item.path
                  })
                end
              end

              vim.fn.setqflist(qf_list)
              vim.cmd('copen')
            end, bufnr)
        end, {
          nargs = "?",
          complete = function()
            return { "all" }
          end
        })
    end


    require("lspconfig").ruby_lsp.setup({
      on_attach = function(client, buffer)
        setup_diagnostics(client, buffer)
        add_ruby_deps_command(client, buffer)
      end,
    })
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
