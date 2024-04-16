return {
  "eliseshaffer/tableau.nvim",
  config = function()
    require('tableau').setup({
        hidden_buffer_types = {
          "neo-tree",
          "nofile",
        },
      })
  end,
}
