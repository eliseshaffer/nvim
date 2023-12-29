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
local utils = require('tableau.utils')
local Config = require('tableau.config').current()
local Buffer = require('tableau.buffer')
local TabLabel = {}

function TabLabel:new(tab_id)
  local o = {
    hl = utils.get_highlight_group_for_tab(tab_id),
    place = vim.api.nvim_tabpage_get_number(tab_id)
  }
  setmetatable(o, self)
  self.__index = self
  return o
end

function TabLabel:render()
  -- return self.hl .. self.name
  return self.hl .. "%" .. self.place .. "T" .. self.hl .. " " .. self.place .. ":"
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
    table.insert(buffers_in_tab, Buffer:new(tab_id, win_id))
  end

  local buftab = ""
  for _, buffer in ipairs(buffers_in_tab) do
    buftab = buftab .. buffer:render()
  end

  tab = TabLabel:new(tab_id):render() .. buftab .. hl .. "%" .. place .. "X — %X"
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
  utils.create_highlight_groups()
  vim.o.tabline = "%!v:lua.render_tableau()"
end

function _G.render_tableau()
  return set_tabline()
end

M.setup({})

return M
