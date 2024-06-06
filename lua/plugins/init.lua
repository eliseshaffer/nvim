return {
  {
    'blaineventurine/sessionable',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = {
      session_dir = vim.fn.stdpath("data") .. "/sessions/",
      pre_save_cmds = { 'Neotree close' },
    }
  }
  -- {
  --   'akinsho/bufferline.nvim',
  --   version = "*",
  --   dependencies = 'nvim-tree/nvim-web-devicons',
  --   config = function()
  --     require("bufferline").setup {}
  --   end,
  -- }
}
