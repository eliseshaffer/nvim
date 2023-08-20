local devicons = require('nvim-web-devicons')
local M = {}

local hl_groups = {
  TableauBackground = {
    fg = "",
    bg = ""
  }
}

local function create_tabline_hl_groups()
end

local function render_icon(bufname)
  local extension = vim.fn.fnamemodify(bufname, ':e')
  local icon, hl = devicons.get_icon(bufname, extension, { default = true })

  return "%#" .. hl .. "#" .. icon
end

local function create_tab(tab_id)
  local tab       = ""
  local current   = vim.api.nvim_get_current_tabpage()
  local win       = vim.api.nvim_tabpage_get_win(tab_id)
  local buf       = vim.api.nvim_win_get_buf(win)
  local bufname   = vim.api.nvim_buf_get_name(buf)
  local icon      = render_icon(bufname)
  local shortname = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ':~:.'))
  local place     = vim.api.nvim_tabpage_get_number(tab_id)
  local hl        = ""

  if tab_id == current then
    hl = "%#Normal#"
  else
    hl = "%#TabLine#"
  end

  tab = hl .. "%" .. place .. "T" .. hl .. "  " .. icon .. hl .. "  " ..
      vim.fn.pathshorten(shortname) .. "  %" .. place .. "X—%X "
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

function _G.render_tabline()
  return set_tabline()
end

vim.o.tabline = '%!v:lua.render_tabline()'

return M
