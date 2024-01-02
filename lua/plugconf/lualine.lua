require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {},
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = { 'encoding', 'fileformat', 'filetype', 'progress', 'location' },
    lualine_y = {},
    lualine_z = {}
  },
})
