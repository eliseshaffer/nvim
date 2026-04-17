-- -------------------------------------------------------------------------------------------
--
-- Keymaps
--
-- -------------------------------------------------------------------------------------------
local key = vim.api.nvim_set_keymap

-- Colors
-- -------------------------------------------------------------------------------------------
key('n', '<leader>kt', ":DarkLightSwitch<CR>", { noremap = true, desc = "Toggle Night Mode" })
key('n', '<leader>dl', ":DarkLightSwitch<CR>", { noremap = true, desc = "Toggle Night Mode" })

-- Files (NvimTree / Telescope)
-- -------------------------------------------------------------------------------------------
key('n', '<leader>ft', ":Neotree toggle<CR>", { noremap = false, desc = "File Tree" })
key('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<CR>", { noremap = false, desc = "Find Files" })
key('n', '<leader>fr', ":lua require('telescope.builtin').resume()<CR>", { noremap = false, desc = "Find Files" })
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
-- -------------------------------------------------------------------------------------------
key('n', '∆', ":MoveLine(1)<CR>", { noremap = true, silent = true })
key('n', '˚', ":MoveLine(-1)<CR>", { noremap = true, silent = true })
key('v', '∆', ":MoveBlock(1)<CR>", { noremap = true, silent = true })
key('v', '˚', ":MoveBlock(-1)<CR>", { noremap = true, silent = true })
-- -------------------------------------------------------------------------------------------

-- Code Navigation (LSP)
-- -------------------------------------------------------------------------------------------
key('n', '<leader>cd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true, desc = "Go To Definition" })
key('n', '<leader>cD', ':lua vim.lsp.buf.declaration()<CR>',
  { noremap = true, silent = true, desc = "Go To Declaration" })
-- key('n', '<leader>cp', ":lua lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true, desc = "Preview Definition" })
key('n', '<leader>cr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true, desc = "List References" })
key('n', '<leader>ci', ':lua vim.lsp.buf.implementation()<CR>',
  { noremap = true, silent = true, desc = "Goto Implementation" })
-- format command defined cia Lsp callback in init.lua
-- key('n', '<leader>cf', ':LspZeroFormat<CR>',
--   { noremap = true, silent = true, desc = "Format File" })
key('n', '<C-k>', ':lua vim.diagnostic.open_float()<CR>',
  { noremap = true, silent = true, desc = "Show Line diagnostics" })
key('n', '<leader>cm', ':Glow<CR>', { noremap = true, silent = true, desc = "Preview markdown" })
-- key('n', '<C-[>', ':lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true, silent = true})
-- key('n', '<C-]>', ':lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true, silent = true})
-- -------------------------------------------------------------------------------------------

-- Snippets
-- -------------------------------------------------------------------------------------------
-- local ls = require("luasnip")
--
-- vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
-- vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
--
-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})

-- Git Tools
-- -------------------------------------------------------------------------------------------
key('n', '<leader>gb', ':BlameToggle<CR>', { noremap = true, silent = true, desc = "Get Remote Link" })
key('n', '<leader>grl', ':GetCommitLink<CR>', { noremap = true, silent = true, desc = "Get Remote Link" })
key('v', '<leader>grl', ':GetCommitLink<CR>', { noremap = true, silent = true, desc = "Get Remote Link" })
key('n', '<leader>gs', ':Neogit kind=vsplit<CR>', { noremap = true, silent = true, desc = "Git Status" })
key('v', '<leader>gs', ':Neogit king=vsplit<CR>', { noremap = true, silent = true, desc = "Git Status" })
key('n', '<leader>gdp', ':Gitsigns preview_hunk<CR>', { noremap = true, silent = true, desc = "Preview Git Hunk" })
key('n', '<leader>gdm', ':DiffviewOpen main<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
key('v', '<leader>gdm', ':DiffviewOpen main<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
key('n', '<leader>gdM', ':DiffviewOpen master<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
key('v', '<leader>gdM', ':DiffviewOpen master<CR>', { noremap = true, silent = true, desc = "Diff Main Branch" })
-- -------------------------------------------------------------------------------------------

-- Window Managment
-- -------------------------------------------------------------------------------------------
key('n', '<leader>wT', ':tabnew<CR>', { noremap = true, silent = true, desc = "Open New Tab" })
key('n', '<leader>wt', ':tabclose<CR>', { noremap = true, silent = true, desc = "Close Current Tab" })
key('n', '<leader>wo', ':tabonly<CR>', { noremap = true, silent = true, desc = "Close Other Tabs" })
key('n', '<leader>ws', ':split<CR>', { noremap = true, silent = true, desc = "Split Horizontally" })
key('n', '<leader>wv', ':vsplit<CR>', { noremap = true, silent = true, desc = "Split Vertically" })
key('n', '<leader>wq', '<C-w>q', { noremap = true, silent = true, desc = "Close Current Window" })

-- Quit Vim
-- -------------------------------------------------------------------------------------------
key('n', '<leader>Q', ':wqa<CR>', { noremap = true, silent = true, desc = "Save And Quit" })
key('v', '<leader>Q', ':wqa<CR>', { noremap = true, silent = true, desc = "Save And Quit" })
-- -------------------------------------------------------------------------------------------

-- Source current file
-- -------------------------------------------------------------------------------------------
key('n', '<leader>l', ':source %<CR>', { noremap = true, silent = true, desc = "Source current file" })
-- -------------------------------------------------------------------------------------------
