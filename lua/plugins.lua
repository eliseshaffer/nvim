local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- ---------------------------------------------------------------------------
  -- UI Plugins
  -- ---------------------------------------------------------------------------
  require("plugins.neotree"),
  require("plugins.tableau"),
  require("plugins.telescope"),
  require("plugins.lualine"),
  require("plugins.nvim-window-picker"),
  require("plugins.which-key"),
  require("plugins.barbecue"),
  require("plugins.scrollbar"),
  require("plugins.indent-blankline"),
  require("plugins.nvim-ufo"),
  require("plugins.statuscol"),
  require("plugins.alpha"),
  require("plugins.gitsigns"),
  require("plugins.vim-pasta"),
  require("plugins.neoscroll"),
  -- { 'ryanoasis/vim-devicons' },

  -- ---------------------------------------------------------------------------
  -- Colorschemes
  -- ---------------------------------------------------------------------------
  'eliseshaffer/vim-one',
  'folke/tokyonight.nvim',
  { 'marko-cerovac/material.nvim', config = function() require 'plugconf.material' end },
  require("plugins.catppuccin"),
  require("plugins.darklight"),

  -- ---------------------------------------------------------------------------
  -- Git Tools
  -- ---------------------------------------------------------------------------
  require("plugins.neogit"),
  require("plugins.diffview"),
  require("plugins.gh"),
  require("plugins.vim-github-link"),

  -- ---------------------------------------------------------------------------
  -- Language Tools
  -- ---------------------------------------------------------------------------
  require("plugins.polyglot"),
  require("plugins.rbs"),
  require("plugins.treesitter"),
  require("plugins.rainbow-delimiters"),
  require("plugins.lsp-zero"),
  require("plugins.autopairs"),
  require("plugins.better-comments"),
  require("plugins.rails"),

  -- ---------------------------------------------------------------------------
  -- Misc. Utilities
  -- ---------------------------------------------------------------------------
  {
    "gnikdroy/projections.nvim",
    branch = "pre_release",
    config = function()
      require("projections").setup({
        workspaces = {
          { "~/code",           { ".git" } },
          { "~/code/redcanary", { ".git" } },
          { "~/code/neovim",    { ".git" } },
        },
      })

      -- Bind <leader>fp to Telescope projections
      require('telescope').load_extension('projections')
      vim.keymap.set("n", "<leader>fp", function() vim.cmd("Telescope projections") end)

      -- Autostore session on VimExit
      local Session = require("projections.session")
      vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
        callback = function() Session.store(vim.loop.cwd()) end,
      })

      vim.api.nvim_create_user_command("SaveProjectSession", function()
        Session.store(vim.loop.cwd())
      end, {})

      vim.api.nvim_create_user_command("RestoreProjectSession", function()
        Session.restore(vim.loop.cwd())
      end, {})
    end
  },
  require("plugins.vim-test"),
  require("plugins.auto-save"),
  require("plugins.move"),
  require("plugins.comment"),
  { 'preservim/vim-pencil' },
  require("plugins.glow"),
  require("plugins.emmet"),
}

local opts = {
  install = {
    colorscheme = { "catppuccin-macchiato" },
  },
  dev = {
    path = "~/code/neovim/",
    pattern = "eliseshaffer",
  }
}

require("lazy").setup(plugins, opts)
