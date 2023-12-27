-- TODO: Add configuration for hidden buffer types
-- TODO: Fix complexity in hidden buffers
-- TODO: Add expression matching to hidden buffers
-- TODO: Fix focused window when that window is hidden
-- TODO: Clean up render function scope; maybe this is not possible?
-- TODO: fix devicons integration

local devicons = require("nvim-web-devicons")
local M = {}
local utils = {}
local Config = {}

local default_config = {
  hl_groups = {
    {
      name = "TableauBackground",
      fg = "#24273a",
      bg = "#24273a"
    },
    {
      name = "TableauCurrentInactive",
      fg = "#24273a",
      bg = "#d0b0ff"
    },
    {
      name = "TableauCurrentActive",
      fg = "#24273a",
      bg = "#b690d6"
    },
    {
      name = "TableauOtherInactive",
      fg = "#d0b0ff",
      bg = "#24273a",
    },
    {
      name = "TableauOtherActive",
      fg = "#b690d6",
      bg = "#24273a",
    },
  },
  hidden_buffer_types = {
    "neo-tree",
    "NeogitStatus",
    "NeogitPopup",
    "NeogitCommitMessage",
    "nofile",
    "prompt",
    "TelescopePrompt",
  }
}

utils.has_key = function(ft, buftype)
  for _, type in ipairs(Config.hidden_buffer_types) do
    if type == ft or type == buftype then
      return true
    end
  end

  return false
end

utils.render_icon = function(bufname)
  local extension = vim.fn.fnamemodify(bufname, ":e")
  local icon, hl = devicons.get_icon(bufname, extension, { default = true })

  return "%#" .. hl .. "#" .. icon
end

utils.create_highlight_groups = function()
  for _, hl in ipairs(Config.hl_groups) do
    vim.api.nvim_set_hl(0, hl.name, { fg = hl.fg, bg = hl.bg })
  end
end

local function create_buffer_tab(wins, prev_hl, tab_id)
  local buftab = ""
  for _, win in pairs(wins) do
    -- #check for hidden buffer types
    -- skip this one
    local current       = vim.api.nvim_get_current_win()
    local buf           = vim.api.nvim_win_get_buf(win)
    local bufname       = vim.api.nvim_buf_get_name(buf)
    local active_on_tab = vim.api.nvim_tabpage_get_win(tab_id)
    local icon          = utils.render_icon(bufname)
    local shortname     = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ":~:."))
    local hl            = ""

    local ft            = vim.api.nvim_buf_get_option(buf, "ft")
    local buftype       = vim.api.nvim_buf_get_option(buf, "buftype")

    if (not utils.has_key(ft, buftype)) then
      if win == current then
        hl = "%#TableauCurrentActive# "
      elseif win == active_on_tab then
        hl = "%#TableauOtherActive#*"
      end

      buftab = buftab .. hl .. "" .. shortname .. " " .. prev_hl
    end
  end

  return buftab
end

local function create_tab(tab_id)
  local tab     = ""
  local current = vim.api.nvim_get_current_tabpage()
  local wins    = vim.api.nvim_tabpage_list_wins(tab_id)
  local place   = vim.api.nvim_tabpage_get_number(tab_id)
  local hl      = ""

  if tab_id == current then
    hl = "%#TableauCurrentInactive#"
  else
    hl = "%#TableauOtherInactive#"
  end

  local buftab = create_buffer_tab(wins, hl, tab_id)

  tab          = hl .. "%" .. place .. "T" .. hl .. " " .. place .. ":" ..
      buftab .. "%" .. place .. "X — %X"
  return tab
end

local function set_tabline()
  local tabline = "%#TabLine#"
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tab in ipairs(tabpages) do
    tabline = tabline .. "" .. create_tab(tab) .. "%#TableauBackground#"
  end
  return tabline
end

M.setup = function(config)
  Config = config
  utils.create_highlight_groups()
  vim.o.tabline = "%!v:lua.render_tableau()"
end

function _G.render_tableau()
  return set_tabline()
end

M.setup(default_config)

return M
