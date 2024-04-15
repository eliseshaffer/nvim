return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function() require 'plugconf.treesitter' end
}
