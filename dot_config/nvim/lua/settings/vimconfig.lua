-- See `:help vim.o`
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard='unnamedplus'
vim.o.clipboard='unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this (24-bit color)
vim.o.termguicolors = true

vim.o.scrolloff = 15
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false, signs=false })
vim.diagnostic.config({virtual_text = false, signs=false})


-- Remap <Esc> to <C-\><C-n> in terminal mode (for toggleterm)
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Map Ctrl-S to save the current buffer
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR>',{ noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-s>', '<C-c>:w<CR>', { noremap = true, silent = true })
