-- TODO: Refactor TabLabel into tabs and nest Buffers/delegate renders
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
local TabLabel = require('tableau.tablabel')

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
  local wins    = vim.api.nvim_tabpage_list_wins(tab_id)

  local buffers_in_tab = {}
  for _, win_id in ipairs(wins) do
    table.insert(buffers_in_tab, Buffer:new(tab_id, win_id))
  end

  local buftab = ""
  for _, buffer in ipairs(buffers_in_tab) do
    buftab = buftab .. buffer:render()
  end

  tab = TabLabel:new(tab_id):render() .. buftab .. TabLabel:new(tab_id):render_close()

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
