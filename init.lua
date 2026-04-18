require('vim._core.ui2').enable()
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
  pattern = "*.code-snippets",
  command = "setlocal ft=json"
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  command = "checktime"
})

vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'neo-tree filesystem [' . tabpagenr() . ']' | quit | endif
]])

vim.lsp.enable({
  "lua",
  "ruby-lsp",
  "rubocop",
  "typescript-language-server",
})

-- Native autocompletion; Should clean this up in the future
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    end
    if client and client:supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<leader>cf", function()
        vim.lsp.buf.format({ bufnr = args.buf, async = true })
      end, { buffer = args.buf, desc = "Format buffer" })
    end
  end,
})

vim.diagnostic.config({ virtual_text = true })

require('keymap')
