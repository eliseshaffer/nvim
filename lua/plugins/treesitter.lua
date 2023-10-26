require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'ruby', 'javascript', 'json', 'html', 'css', 'lua', 'vim', 'scss', 'embedded_template' },
  ignore_installed = { "markdown" },
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
}
