return {
  'goolord/alpha-nvim',
  config = function()
    local dashboard = require "alpha.themes.dashboard"
    math.randomseed(os.time())

    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.hl = "Function"
      -- b.opts.hl_shortcut = "Type"
      return b
    end

    local function footer()
      local v = vim.version()
      local version = ' v' .. v.major .. '.' .. v.minor .. '.' .. v.patch
      local stats = require('lazy').stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return {
        [[ ]],
        [[ ]],
        version .. '                              ' .. '⚡' .. stats.count .. ' plugins',
      }
    end

    local custom_header = {
      type = "text",
      val = {
        [[ ]],
        [[ ]],
        [[ ]],
        [[░██                                            ░██                             ░██ ░██                     ]],
        [[░██                                            ░██                             ░██                         ]],
        [[░████████   ░███████  ░██    ░██    ░██  ░████████ ░██    ░██        ░███████  ░██ ░██ ░███████   ░███████ ]],
        [[░██    ░██ ░██    ░██ ░██    ░██    ░██ ░██    ░██ ░██    ░██       ░██    ░██ ░██ ░██░██        ░██    ░██]],
        [[░██    ░██ ░██    ░██  ░██  ░████  ░██  ░██    ░██ ░██    ░██       ░█████████ ░██ ░██ ░███████  ░█████████]],
        [[░██    ░██ ░██    ░██   ░██░██ ░██░██   ░██   ░███ ░██   ░███       ░██        ░██ ░██       ░██ ░██       ]],
        [[░██    ░██  ░███████     ░███   ░███     ░█████░██  ░█████░██ ░██    ░███████  ░██ ░██ ░███████   ░███████ ]],
        [[                                                          ░██  ░█                                          ]],
        [[                                                    ░███████  ░█                                           ]],
      },
      opts = {
        position = "center",
        hl = "Keyword",
      },
    }

    dashboard.section.buttons.val = {
      button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      button("s", "  Session", ":SearchSession<CR>"),
      button("f", "  Find file", ":Telescope find_files<CR>"),
      button("t", "󰙅  File Tree", ":Neotree toggle<CR>"),
      button("p", "  Plugins", ":Lazy<CR>"),
      button("u", "  Sync plugins", ":Lazy sync<CR>"),
      button("q", "󰗼  Quit", "<Cmd>qa<CR>"),
      button("l", "λ  Update laguage servers", ":MasonUpdate<CR>")
    }

    dashboard.section.header.val = custom_header.val
    dashboard.section.header.opts = custom_header.opts
    dashboard.section.footer.val = footer()
    -- dashboard.section.footer.opts.hl = "Comment"

    require "alpha".setup(dashboard.opts)

    -- hide tabline on startup screen
    vim.cmd [[
    augroup alpha_tabline
      au!
      au FileType alpha set showtabline=0 | au BufUnload <buffer> set showtabline=2
    augroup END
    ]]
  end
}
