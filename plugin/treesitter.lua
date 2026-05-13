vim.pack.add({
  'http://github.com/nvim-treesitter/nvim-treesitter'
})

require('nvim-treesitter').setup()
require('nvim-treesitter').install { 'ruby', 'javascript', 'css', 'typescript', 'lua' }

