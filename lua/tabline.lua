local devicons = require('nvim-web-devicons')
local M = {}
local utils = {}

local hl_groups = {
  TableauBackground = {
    fg = "#24273a",
    bg = "#c0a0f6"
  },
  TableauSelectedInactive = {
    fg = "#24273a",
    bg = "#d0b0ff"
  },
  TableauSelectedActive = {
    fg = "#24273a",
    bg = "#b690d6"
  }
}

utils.render_icon = function(bufname)
  local extension = vim.fn.fnamemodify(bufname, ':e')
  local icon, hl = devicons.get_icon(bufname, extension, { default = true })

  return "%#" .. hl .. "#" .. icon
end

utils.create_highlight_groups = function()
  vim.api.nvim_set_hl(0, 'TableauSelected', { fg = hl_groups.TableauSelectedInactive.fg, bg = hl_groups.TableauSelectedInactive.bg })
  vim.api.nvim_set_hl(0, 'TableauSelectedActive', { fg = hl_groups.TableauSelectedActive.fg, bg = hl_groups.TableauSelectedActive.bg })
end

local function create_buffer_tab(wins, prev_hl)
  local buftab = ""
  for _, win in pairs(wins) do
    local current   = vim.api.nvim_get_current_win()
    local buf       = vim.api.nvim_win_get_buf(win)
    local bufname   = vim.api.nvim_buf_get_name(buf)
    local icon      = utils.render_icon(bufname)
    local shortname = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ':~:.'))
    local hl = ""
    if win == current then
      hl = "%#TableauSelectedActive#"
    end

    buftab          = buftab .. hl .. " " .. shortname .. ' ' .. prev_hl
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
    hl = "%#TableauSelected#"
  else
    hl = "%#TabLine#"
  end

  local buftab = create_buffer_tab(wins, hl)

  tab          = hl .. "%" .. place .. "T" .. hl ..
      buftab .. " %" .. place .. "X—%X "
  return tab
end

local function set_tabline()
  local tabline = "%#TabLine#"
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tab in ipairs(tabpages) do
    tabline = tabline .. create_tab(tab) .. "%#TabLine#"
  end
  return tabline
end

M.setup = function()
end

function _G.render_tableau()
  return set_tabline()
end
utils.create_highlight_groups()
vim.o.tabline = '%!v:lua.render_tableau()'

return M
