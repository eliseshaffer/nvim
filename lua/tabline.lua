-- TODO: Remove Telescope buffers from Tabline
-- TODO: Neotree, NERDTree, etc.
-- TODO: Neogit
-- TODO: Fix complexity in hidden buffers


local devicons = require("nvim-web-devicons")
local M = {}
local utils = {}

local hl_groups = {
  {
    name = "TableauBackground",
    fg = "#24273a",
    bg = "#c0a0f6"
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
    fg = "#24273a",
    bg = "#d59dc6"
  },
  {
    name = "TableauOtherActive",
    fg = "#24273a",
    bg = "#f5bde6"
  },
}

local hidden_buffer_types = {
  "neo-tree",
  "NeogitStatus",
  "nofile",
}
function has_key(ft)
  for _, type in ipairs(hidden_buffer_types) do
    if type == ft then
      return true
    end
  end

  return false
end

function build_map(table)
  for _, type in ipairs(hidden_buffer_types) do

  end
end

utils.render_icon = function(bufname)
  local extension = vim.fn.fnamemodify(bufname, ":e")
  local icon, hl = devicons.get_icon(bufname, extension, { default = true })

  return "%#" .. hl .. "#" .. icon
end

utils.create_highlight_groups = function()
  for _, hl in ipairs(hl_groups) do
    vim.api.nvim_set_hl(0, hl.name, { fg = hl.fg, bg = hl.bg })
  end
end

utils.filter_buffer_if_hidden = function(buf_id)
  local filetype = vim.api.nvim_buf_get_option(buf_id, "ft")
  has_key(hidden_buffer_types, filetype)
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

    if has_key(ft) or has_key(buftype) then
      print("yes")
    else
    
      if win == current then
      hl = "%#TableauCurrentActive#"
    elseif win == active_on_tab then
      hl = "%#TableauOtherActive#"
    end

    buftab = buftab .. hl .. " " .. shortname .. "|" .. ft .. "|" .. buftype .. " " .. prev_hl
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
vim.o.tabline = "%!v:lua.render_tableau()"

return M
