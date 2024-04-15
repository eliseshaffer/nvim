return {
  's1n7ax/nvim-window-picker',
  version = 'v2.*',
  config = function()
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
  end,
}
