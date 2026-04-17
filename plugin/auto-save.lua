vim.pack.add({
  'http://github.com/pocco81/auto-save.nvim'
})
require('auto-save').setup(
  {
    execution_message = {
      message = function() return "" end,
    }
  }
)
