local lsp_status = function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then
    return "LSP Inactive"
  end

  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end

  return table.concat(client_names, ",")
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
  -- config = function() require 'plugconf.lualine' end,
  opts = {
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
}
