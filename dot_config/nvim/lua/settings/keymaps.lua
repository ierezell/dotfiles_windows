-- document existing key chains
require('which-key').register {
    ['<leader>c'] = {name = '[C]ode', _ = 'which_key_ignore'},
    ['<leader>d'] = {name = '[D]ocument', _ = 'which_key_ignore'},
    ['<leader>g'] = {name = '[G]it', _ = 'which_key_ignore'},
    ['<leader>h'] = {name = 'Git [H]unk', _ = 'which_key_ignore'},
    ['<leader>r'] = {name = '[R]ename', _ = 'which_key_ignore'},
    ['<leader>s'] = {name = '[S]earch', _ = 'which_key_ignore'},
    ['<leader>t'] = {name = '[T]oggle', _ = 'which_key_ignore'},
    ['<leader>w'] = {name = '[W]orkspace', _ = 'which_key_ignore'}
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({['<leader>'] = {name = 'VISUAL <leader>'}}, {mode = 'v'})

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', {silent = true})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {expr = true, silent = true})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {expr = true, silent = true})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {desc = 'Go to previous diagnostic message'})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {desc = 'Go to next diagnostic message'})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {desc = 'Open floating diagnostic message'})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostics list'})
vim.keymap.set('n', '<leader>rr', "<cmd>Rest run<cr>", {desc = "Run the request under the cursor"})
vim.keymap.set('n', '<leader>rr', "<cmd>Rest run last<cr>", {desc = "Re-Run latest request"})

vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>", {desc = '[?] Open the file browser'})

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    {desc = '[?] Open the file browser'})

-- Alternatively, using lua API
vim.keymap.set("n", "<space>sb", function() require("telescope").extensions.file_browser.file_browser() end,
    {desc = '[S]earch in [B]rowser'})

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, {desc = '[?] Find recently opened files'})
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, {desc = '[ ] Find existing buffers'})
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10, previewer = false
    })
end, {desc = '[/] Fuzzily search in current buffer'})
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, {desc = '[S]earch [/] in Open Files'})
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, {desc = '[S]earch [S]elect Telescope'})
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, {desc = 'Search [G]it [F]iles'})
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {desc = '[S]earch [F]iles'})
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {desc = '[S]earch [H]elp'})
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {desc = '[S]earch current [W]ord'})
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, {desc = '[S]earch by [G]rep'})
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', {desc = '[S]earch by [G]rep on Git Root'})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, {desc = '[S]earch [D]iagnostics'})
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, {desc = '[S]earch [R]esume'})
