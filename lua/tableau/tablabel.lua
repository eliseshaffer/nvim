local utils = require('tableau.utils')
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
  return self.hl .. "%" .. self.place .. "T" .. self.hl .. " " .. self.place .. ":"
end

function TabLabel:render_close()
  return self.hl .. "%" .. self.place .. "X — %X"
end

return TabLabel
