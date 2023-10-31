-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
require "core"

-- CSpell
vim.opt.spelllang = "en,fr"
vim.opt.spellsuggest = "best,9"

-- Lazygit
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available

-- Highlight on yank
vim.cmd [[
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 80})
augroup END
]]
