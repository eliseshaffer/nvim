vim.pack.add({
  'http://github.com/nvim-tree/nvim-web-devicons',
  'http://github.com/nvimdev/dashboard-nvim'
})


header = {
  [[ ]],
  [[ ]],
  [[ ]],
  [[ ░██                                            ░██            ]],
  [[ ░██                                            ░██            ]],
  [[ ░████████   ░███████  ░██    ░██    ░██  ░████████ ░██    ░██ ]],
  [[ ░██    ░██ ░██    ░██ ░██    ░██    ░██ ░██    ░██ ░██    ░██ ]],
  [[ ░██    ░██ ░██    ░██  ░██  ░████  ░██  ░██    ░██ ░██    ░██ ]],
  [[ ░██    ░██ ░██    ░██   ░██░██ ░██░██   ░██   ░███ ░██   ░███ ]],
  [[ ░██    ░██  ░███████     ░███   ░███     ░█████░██  ░█████░██ ]],
  [[                                                           ░██ ]],
  [[                                                     ░███████  ]],
  [[ ]],
  [[ ]],
  [[ ]],

}

local function number_of_plugins()
  local count = #vim.pack.get()
  return count
end

local v = vim.version()

require('dashboard').setup({
  theme = 'doom',
  config = {
    header = header,
    center = {
      {
        icon="  ",
        desc = "New File",
        key = "n",
        action = "ene"
      },
      {
        icon = "  ",
        desc = "Find File",
        key = "f",
        action = "Telescope find_files"
      },
      {
        icon = "󰙅  ",
        desc = "File Tree",
        key = "t",
        action = "Neotree toggle"
      },
      {
        icon = "  ",
        desc = "Sync Plugins                   ",
        key = "u",
        action = "lua vim.pack.update()"
      },
      {
        icon = "λ  ",
        desc = "Manage Language Servers",
        key = "l",
        action = "Mason"
      },
      {
        icon = "󰗼  ",
        desc = "Quit",
        key = "q",
        action = "qa"
      },
    },
    footer = {
      "",
      "⚡" .. number_of_plugins() .. " Plugins Loaded",
      "",
      ' v' .. v.major .. '.' .. v.minor .. '.' .. v.patch
    }
  }
})
