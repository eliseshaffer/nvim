return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  config = function()
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          ".yarn",
          ".git/",
        },
        prompt_prefix = "λ -> ",
        selection_caret = "|> ",
        layout_strategy = "bottom_pane",
        layout_config = {
          bottom_pane = {
            prompt_position = "bottom",
          },
        },
        mappings = {
          i = {
            ["<c-e>"] = require('telescope.actions').to_fuzzy_refine,
          }
        }
        -- Don't pass to normal mode with ESC, problem with telescope-project
        -- mappings = {
        --   i = {
        --     ["<esc>"] = actions.close,
        --   },
        -- },
      },
      --extensions = {
      --fzy_native = {
      --override_generic_sorter = false,
      --override_file_sorter = true,
      --},
      --project = {
      --base_dirs = {
      --'~/repos'
      --}
      --}
      --}
    })
  end,
}
