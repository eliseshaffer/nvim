vim.pack.add({
  'http://github.com/s1n7ax/nvim-window-picker'
})
require('window-picker').setup({
  highlights = {
    statusline = {
      focused = {
        fg = '#303446',
        bg = '#a6d189',
        bold = false,
      },
      unfocused = {
        fg = '#303446',
        bg = '#babbf1',
        bold = false,
      },
    },
  },
})
