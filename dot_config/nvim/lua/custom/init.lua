-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
require "core"

vim.opt.spelllang="en,fr"
vim.opt.spellsuggest="best,9"
