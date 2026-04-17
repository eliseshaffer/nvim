vim.pack.add({
  'http://github.com/lukas-reineke/indent-blankline.nvim'
})

require('ibl').setup({ exclude = { filetypes = { "dashboard" } } })
