-- TODO: Refactor Tabs in the same way as buffers
-- TODO: Extract close button as its own component
-- TODO: Handle buffer clicks transitioning focus within a tab
-- FIX: Fix complexity in hidden buffers
-- TODO: Add expression matching to hidden buffers
-- FIX: Fix focused window when that window is hidden
-- TODO: Clean up render function scope; maybe this is not possible?
-- TODO: collapse init.lua filenames
-- FIX: fix devicons integration
-- FIX: hide lsp loclist filtering

local devicons = require("nvim-web-devicons")
local M = {}
local utils = {}
local Config = {}
local Buffer = {}

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

utils.get_highlight_group_for_win = function(tab_id, win_id)
  local buf           = vim.api.nvim_win_get_buf(win_id)
  local current_tab   = vim.api.nvim_get_current_tabpage()
  local active_on_tab = vim.api.nvim_tabpage_get_win(tab_id)
  local current_buf   = vim.api.nvim_get_current_win()
  local ft            = vim.api.nvim_buf_get_option(buf, "ft")
  local buftype       = vim.api.nvim_buf_get_option(buf, "buftype")
  local hl            = ""

  if (not utils.has_key(ft, buftype)) then
    if win_id == current_buf then
      hl = "%#TableauCurrentActive#"
    elseif win_id ~= current_buf and tab_id == current_tab then
      hl = "%#TableauCurrentInactive#"
    elseif tab_id ~= current_tab and win_id == win_id ~= current_buf then
      hl = "%#TableauOtherInactive#"
    elseif win_id == active_on_tab then
      hl = "%#TableauOtherActive#*"
    end
  end

  return hl
end

-- tab = {
--   hl = "TableauCurrentInactive",
--   buffers = {
--     {
--       hl = "TableauCurrentActive",
--       name = 'init.lua'
--     },
--     {
--       hl = "TableauCurrentActive",
--       name = 'keymap.lua'
--     },
--   }
-- }
function Buffer:new(o)
  o = o or {}     -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

function Buffer:render()
  return self.hl .. ' ' .. self.name .. ' '
end

Buffer.create_buffer = function(tab_id, win_id)
  local buf     = vim.api.nvim_win_get_buf(win_id)
  local bufname = vim.api.nvim_buf_get_name(buf)
  local name    = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ":~:."))
  return Buffer:new({
    hl = utils.get_highlight_group_for_win(tab_id, win_id),
    name = name,
  })
end

local function create_tab(tab_id)
  local tab     = ""
  local current = vim.api.nvim_get_current_tabpage()
  local wins    = vim.api.nvim_tabpage_list_wins(tab_id)
  local place   = vim.api.nvim_tabpage_get_number(tab_id)
  local hl      = "" -- utils.get_highlight_group_for_tab_win(tab_id, win_id)

  if tab_id == current then
    hl = "%#TableauCurrentInactive#"
  else
    hl = "%#TableauOtherInactive#"
  end

  local buffers_in_tab = {}
  for _, win_id in ipairs(wins) do
    table.insert(buffers_in_tab, Buffer.create_buffer(tab_id, win_id))
  end

  local buftab = ""
  for _, buffer in ipairs(buffers_in_tab) do
    buftab = buftab .. buffer:render()
  end

  -- local buftab = create_buffer_tab(wins, hl, tab_id)

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
