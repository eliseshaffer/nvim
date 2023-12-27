local devicons = require('nvim-web-devicons')
local M = {}

local hl_groups = {
  TableauBackground = {
    fg = "",
    bg = ""
  },
}

local function render_icon(bufname)
  local extension = vim.fn.fnamemodify(bufname, ':e')
  local icon, hl = devicons.get_icon(bufname, extension, { default = true })

  return "%#" .. hl .. "#" .. icon
end

local function create_buffer_tab(wins, hl)
  local buftab = ""
  for _, win in pairs(wins) do
    -- local current   = vim.api.nvim_get_current_win()
    local buf       = vim.api.nvim_win_get_buf(win)
    local bufname   = vim.api.nvim_buf_get_name(buf)
    local icon      = render_icon(bufname)
    local shortname = vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ':~:.'))

    buftab          = buftab .. " " .. icon .. " " .. hl .. shortname .. ' |'
  end

  return buftab
end

local function create_tabline_hl_groups()
end

local function create_tab(tab_id)
  local tab     = ""
  local current = vim.api.nvim_get_current_tabpage()
  local wins    = vim.api.nvim_tabpage_list_wins(tab_id)
  local place   = vim.api.nvim_tabpage_get_number(tab_id)
  local hl      = ""

  if tab_id == current then
    hl = "%#Normal#"
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

function _G.render_tabline()
  return set_tabline()
end

vim.o.tabline = '%!v:lua.render_tabline()'

return M
