
vim.pack.add({
  'http://github.com/nvim-lua/plenary.nvim',
  'http://github.com/TimUntersberger/neogit'
})

local neogit = require("neogit")

neogit.setup({
  kind = "vsplit",
  disable_context_highlighting = true,
  commit_editor = {
    kind = "split",
  },
  commit_popup = {
    kind = "split",
  },
  integrations = {
    diffview = true,
  }
})

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter" }, { pattern = "NeogitStatus", command = "Neotree close" })
