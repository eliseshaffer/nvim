require'nvim-treesitter.configs'.setup {
  ensure_installed = { 'ruby', 'javascript', 'json', 'html', 'css', 'lua', 'vim', 'scss' },
  ignore_installed = { "markdown" },
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
  rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    disable = { 'jsx', 'html', 'eruby', 'eruby.html' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
    hlgroups = {
      'Constant',
      'Keyword',
      'TSPunctBracket',
      'String'
    },
  }
}
