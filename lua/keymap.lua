-- -------------------------------------------------------------------------------------------
--
-- Keymaps
--
-- -------------------------------------------------------------------------------------------
vim.g.mapleader = ","
vim.opt.mouse = "a"
local key = vim.api.nvim_set_keymap

-- Colors
-- -------------------------------------------------------------------------------------------
key('n', '<leader>kt', ":DarkLightSwitch<CR>", { noremap = true, desc = "Toggle Night Mode" })
key('n', '<leader>dl', ":DarkLightSwitch<CR>", { noremap = true, desc = "Toggle Night Mode" })

-- Files (NvimTree / Telescope)
-- -------------------------------------------------------------------------------------------
-- key('n', '<leader>ft', ":Telescope file_browser initial_mode=normal<CR>", { noremap = false })
key('n', '<leader>ft', ":Neotree toggle<CR>", { noremap = false, desc = "File Tree" })
key('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<CR>", { noremap = false, desc = "Find Files" })
key('n', '<leader>fa', ":Telescope find_files find_command=rg,--hidden,--files<CR>",
  { noremap = false, desc = "Find All Files" })
key('n', '<leader>fg', ":lua require('telescope.builtin').git_files()<CR>", { noremap = false, desc = "Find Git Files" })
key('n', '<leader>fs', ":Telescope projections<CR>", { noremap = false, desc = "Find Session" })
key('n', '<leader>s', ":lua require('telescope.builtin').live_grep()<CR>", { noremap = false, desc = "Search Text" })

-- Project Management
-- -------------------------------------------------------------------------------------------
key('n', '<leader>pl', ":Telescope projections<CR>", { noremap = false, desc = "List Projects" })
key('n', '<leader>ps', ":SaveProjectSession<CR>", { noremap = false, desc = "Save Project Session" })
key('n', '<leader>pr', ":RestoreProjectSession<CR>", { noremap = false, desc = "Restore Project Session" })

-- Tests (vim-test)
-- -------------------------------------------------------------------------------------------
key('n', '<leader>ts', ":TestSuite<CR>", { noremap = false, desc = "Run Test Suite" })
key('n', '<leader>tf', ":TestFile<CR>", { noremap = false, desc = "Run Tests For Current File" })
key('n', '<leader>tn', ":TestNearest<CR>", { noremap = false, desc = "Run Nearest Test" })
key('n', '<leader>tl', ":TestLast<CR>", { noremap = false, desc = "Run Last Test" })
-- -------------------------------------------------------------------------------------------

-- Line Movement (move.nvim)
--   - I don't have the correct character for Alt-H and Alt-L
--   - Alt maps don't work on Mac withouth the special characters
-- -------------------------------------------------------------------------------------------
key('n', '∆', ":MoveLine(1)<CR>", { noremap = true, silent = true })
key('n', '˚', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
key('v', '∆', ":MoveBlock(1)<CR>", { noremap = true, silent = true })
key('v', '˚', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-j>', ":MoveLine(1)<CR>", { noremap = true, silent = true })
-- key('n', 'A-h', ":MoveHChar(1)<CR>", { noremap = true, silent = true })
-- key('n', 'A-l', ":MoveHChar(-1)<CR>", { noremap = true, silent = true })
-- key('v', 'A-h', ":MoveHBlock(1)<CR>", { noremap = true, silent = true })
-- key('v', 'A-l', ":MoveHBlock(-1)<CR>", { noremap = true, silent = true })
-- -------------------------------------------------------------------------------------------

-- Code Navigation (LSP)
-- -------------------------------------------------------------------------------------------
key('n', '<leader>cd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true, desc = "Go To Definition" })
key('n', '<leader>cD', ':lua vim.lsp.buf.declaration()<CR>',
  { noremap = true, silent = true, desc = "Go To Declaration" })
key('n', '<leader>cr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true, desc = "List References" })
key('n', '<leader>ci', ':lua vim.lsp.buf.implementation()<CR>',
  { noremap = true, silent = true, desc = "Goto Implementation" })
key('n', '<leader>cf', ':LspZeroFormat<CR>',
  { noremap = true, silent = true, desc = "Format File" })
key('n', '<C-k>', ':lua vim.diagnostic.open_float()<CR>',
  { noremap = true, silent = true, desc = "Show Line diagnostics" })
key('n', '<leader>cm', ':Glow<CR>', { noremap = true, silent = true, desc = "Preview markdown" })
-- key('n', '<C-[>', ':lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true})
-- key('n', '<C-]>', ':lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true})
-- -------------------------------------------------------------------------------------------

-- Git Tools
-- -------------------------------------------------------------------------------------------
key('n', '<leader>grl', ':GetCommitLink<CR>', { noremap = true, silent = true, desc = "Get Remote Link" })
key('v', '<leader>grl', ':GetCommitLink<CR>', { noremap = true, silent = true, desc = "Get Remote Link" })
key('n', '<leader>gs', ':Neogit kind=vsplit<CR>', { noremap = true, silent = true, desc = "Git Status" })
key('v', '<leader>gs', ':Neogit king=vsplit<CR>', { noremap = true, silent = true, desc = "Git Status" })
key('n', '<leader>gdp', ':Gitsigns preview_hunk_inline<CR>', { noremap = true, silent = true, desc = "Preview Git Hunk" })
key('n', '<leader>gdm', ':DiffviewOpen main<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
key('v', '<leader>gdm', ':DiffviewOpen main<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
key('n', '<leader>gdM', ':DiffviewOpen master<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
key('v', '<leader>gdM', ':DiffviewOpen master<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
-- -------------------------------------------------------------------------------------------

-- Window Managment
-- -------------------------------------------------------------------------------------------
key('n', '<leader>wT', ':tabnew<CR>', { noremap = true, silent = true, desc = "Open New Tab" })
key('n', '<leader>wt', ':tabclose<CR>', { noremap = true, silent = true, desc = "Close Current Tab" })
key('n', '<leader>ws', ':split<CR>', { noremap = true, silent = true, desc = "Split Horizontally" })
key('n', '<leader>wv', ':vsplit<CR>', { noremap = true, silent = true, desc = "Split Vertically" })
key('n', '<leader>wq', '<C-w>q', { noremap = true, silent = true, desc = "Close Current Window" })

-- Quit Vim
-- -------------------------------------------------------------------------------------------
key('n', '<leader>Q', ':wqa<CR>', { noremap = true, silent = true, desc = "Save And Quit" })
key('v', '<leader>Q', ':wqa<CR>', { noremap = true, silent = true, desc = "Save And Quit" })
-- -------------------------------------------------------------------------------------------

local status, wk = pcall(require, "which-key")

if not status then
  return
end

wk.setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
  window = {
    border = "single",        -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
    padding = { 1, 0, 4, 0 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,             -- value between 0-100 0 for fully opaque and 100 for fully transparent
    zindex = 1000,            -- positive value to position WhichKey above other floating windows.
  },
  layout = {
    -- height = { min = 4, max = 25 }, -- min and max height of the columns
    -- width = { min = 15, max = 50 }, -- min and max width of the columns
    spacing = 3,      -- spacing between columns
    align = "center", -- align columns left, center or right
  },
}

wk.register({
  t = "Tests",
  f = "Files",
  p = "Projects",
  g = {
    name = "Git",
    d = {
      name = "Diff",
      p = "Preview Hunk"
    },
    r = "Remote"
  },
  c = "Code",
  w = "Window",
  d = "Darklight",
  k = "Darklight"
}, { prefix = "<leader>" })
