vim.pack.add({
  'http://github.com/nvim-treesitter/nvim-treesitter'
})

require('nvim-treesitter').setup(
  {
    ensure_installed = { 'ruby', 'javascript', 'json', 'html', 'css', 'lua', 'vim', 'scss', 'embedded_template' },
    ignore_installed = { "markdown" },
    highlight = {
      enable = true, -- false will disable the whole extension
      additional_vim_regex_highlighting = true,
    },
  }
)

