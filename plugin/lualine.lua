vim.pack.add({
  'http://github.com/nvim-tree/nvim-web-devicons',
  'http://github.com/nvim-lualine/lualine.nvim'
})
local lsp_status = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then
    return "LSP Inactive"
  end

  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end

  return table.concat(client_names, ",")
end

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff' },
    lualine_c = { 'filename' },
    lualine_x = { 'filetype' },
    lualine_y = { 'diagnostics', lsp_status },
    lualine_z = { 'progress', 'location' }
  },
}
