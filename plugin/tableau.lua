vim.pack.add({
  'http://github.com/nvim-tree/nvim-web-devicons',
  'http://github.com/eliseshaffer/tableau.nvim',
})

require('tableau').setup({
  hidden_buffer_types = {
    "neo-tree",
    "nofile",
    "TelescopePrompt"
  },
})
