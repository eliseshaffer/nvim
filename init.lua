-- -------------------------------------------------------------------------------------------
--
-- General Settings
--
-- -------------------------------------------------------------------------------------------
vim.o.showtabline = 2
vim.o.laststatus = 3
vim.o.sidescroll = 3
vim.o.autoread = true
vim.o.linebreak = true
vim.o.breakat = " "
vim.o.colorcolumn = "80"
vim.o.clipboard = 'unnamedplus'
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.writebackup = false
vim.o.undofile = false
vim.wo.number = true
vim.wo.wrap = false
vim.o.signcolumn = "auto:4"
vim.wo.relativenumber = true
vim.o.updatetime = 1000
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.g.mapleader = ","
vim.opt.mouse = "a"
if vim.fn.has("termguicolors") == 1 then
  vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
  vim.go.t_8b = "[[48;2;%lu;%lu;%lum"
  vim.opt.termguicolors = true
end

-- -------------------------------------------------------------------------------------------
--
-- Autocommands
--
-- -------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  pattern = "*",
  command = "setlocal number relativenumber"
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  pattern = "*",
  command = "setlocal number norelativenumber"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.rbs",
  command = "setlocal ft=rbs"
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.code-snippets",
  command = "setlocal ft=json"
})

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = "*.turbo_stream.erb",
--   command = "setlocal ft=eruby.html"
-- })
--
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = "*.html.erb",
--   command = "setlocal ft=eruby.html"
-- })

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "checktime"
})

vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'neo-tree filesystem [' . tabpagenr() . ']' | quit | endif
]])

-- -------------------------------------------------------------------------------------------
--
-- Plugin Configs
--
-- -------------------------------------------------------------------------------------------
require('plugins')
require('keymap')
