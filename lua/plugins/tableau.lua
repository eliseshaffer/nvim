return {
  "eliseshaffer/tableau.nvim",
  dev = "true",
  config = function()
    require('tableau').setup({
        hidden_buffer_types = {
          "neo-tree",
          "nofile",
          "TelescopePrompt"
        },
      })
  end,
}
