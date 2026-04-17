vim.pack.add({
'http://github.com/petertriho/nvim-scrollbar'
  })
require('scrollbar').setup{
  excluded_buftypes = {
    "terminal",
  },
  excluded_filetypes = {
    "cmp_docs",
    "cmp_menu",
    "noice",
    "prompt",
    "TelescopePrompt",
    'neo-tree'
  },
}
