return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  opts = {
    ensure_installed = { 'ruby', 'javascript', 'json', 'html', 'css', 'lua', 'vim', 'scss', 'embedded_template' },
    ignore_installed = { "markdown" },
    highlight = {
      enable = true,              -- false will disable the whole extension
      additional_vim_regex_highlighting = true,
    },
  }
}
