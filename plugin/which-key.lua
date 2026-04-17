vim.pack.add({
  'http://github.com/folke/which-key.nvim',
})

local status, wk = pcall(require, "which-key")

if not status then
  return
end

wk.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  win = {
    -- don't allow the popup to overlap with the cursor
    no_overlap = true,
    -- width = 200,
    -- height = { min = 4, max = 25 },
    col = 3,
    -- row = math.huge,
    border = "single",
    padding = { 3, 2 }, -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = "center",
    zindex = 1000,
    -- Additional vim.wo and vim.bo options
    bo = {},
    wo = {
      -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
  },
  layout = {
    -- height = { min = 4, max = 25 }, -- min and max height of the columns
    -- width = { min = 15, max = 50 }, -- min and max width of the columns
    spacing = 3,      -- spacing between columns
    align = "center", -- align columns left, center or right
  },
}

wk.add({
  { "<leader>a",  group = "AI/Claude" },
  { "<leader>c",  group = "Code" },
  { "<leader>d",  group = "Darklight" },
  { "<leader>f",  group = "Files" },
  { "<leader>g",  group = "Git" },
  { "<leader>gd", group = "Git Diff" },
  { "<leader>gr", group = "Git Remote" },
  { "<leader>p",  group = "Projects" },
  { "<leader>t",  group = "Tests" },
  { "<leader>w",  group = "Window" },
})
