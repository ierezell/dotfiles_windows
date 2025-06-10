-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
local wk = require("which-key")

wk.add({ 
    { "<leader>", group = "VISUAL <leader>", mode = "v" }
})

wk.add({
    { "<leader>c", group = "[C]ode" },
    { "<leader>c_", hidden = true },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>d_", hidden = true },
    { "<leader>f", group = "[F]loat" },
    { "<leader>f_", hidden = true },
    { "<leader>g", group = "[G]it" },
    { "<leader>g_", hidden = true },
    { "<leader>h", group = "[H]arpoon" },
    { "<leader>h_", hidden = true },
    { "<leader>r", group = "[R]ename" },
    { "<leader>r_", hidden = true },
    { "<leader>s", group = "[S]earch" },
    { "<leader>s_", hidden = true },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>t_", hidden = true },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>w_", hidden = true },
    { "[", group = "Previous" },
    { "[_", hidden = true },
    { "]", group = "Next" },
    { "]_", hidden = true },
})

vim.api.nvim_create_user_command('LiveGrepGitRoot', telescope_live_grep_git_root, {})
--------------------------
-- PRE-DEFINED-MAPPINGS --
--------------------------
-- ctrl-w => Windows mappings

--Comment mappings --
--https://github.com/numToStr/Comment.nvim
-- GC
--`gcc` - Toggles the current line using linewise comment (or just gc in visual)
--`gbc` - Toggles the current line using blockwise comment (or just gb in visual)
--`[count]gcc` - Toggles the number of line given as a prefix-count using linewise
--`[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
--`gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
--`gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

-- Harpoon --
-- "<leader>ha" '[H]arpoon [A]dd'
-- "<leader>hl" '[H]arpoon [L]ist'
-- "<leader>lh" '[L]ist [H]arpoon'
-- "<leader>h1" '[H]arpoon 1'
-- "<leader>h2" '[H]arpoon 2'
-- "<leader>h3" '[H]arpoon 3'
-- "<leader>h4" '[H]arpoon 4'
-- "<leader>h5" '[H]arpoon 5'
-- "<leader>hn" '[H]arpoon [N]ext'
-- "<leader>hp" '[H]arpoon [P]revious'

---------
-- VIM --
---------
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<leader>tt', require("nvim-tree.api").tree.toggle, { desc = '[T]oggle [T]ree' })
vim.keymap.set('n', '<leader>te', require("edgy").toggle, { desc = '[T]oggle [Edgy]' })
-- Remap <Esc> to <C-\><C-n> in terminal mode (for toggleterm)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Map Ctrl-S to save the current buffer
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<C-s>', '<C-c>:w<CR>', { noremap = true, silent = true })

------------
-- [C]ode --
------------
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
    { desc = 'Go to previous [d]iagnostic message', noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
    { desc = 'Go to next [d]iagnostic message', noremap = true, silent = true })
vim.keymap.set('n', '<leader>fd', vim.diagnostic.open_float, { desc = 'Open [f]loating [d]iagnostic' })
vim.keymap.set('n', '<leader>ld', function() require("trouble").toggle("diagnostics") end, { desc = '[l]ist [d]iagnostics' })
vim.keymap.set('n', '<leader>ts', function() require("trouble").toggle("symbols") end, { desc = '[t]oggle [s]ymbols' })
vim.keymap.set('n', '<leader>tl', function() require("trouble").toggle("lsp") end, { desc = '[t]oggle [l]sp' })
vim.keymap.set('n', '<leader>lq', function() require("trouble").toggle("quickfix") end, { desc = '[l]ist [q]uickfix' })
vim.keymap.set('n', '<leader>ll', function() require("trouble").toggle("loclist") end, { desc = '[l]ist [l]oclist' })
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end, { desc = '[g]o to [R]eferences' })

vim.keymap.set('n', '<leader>rr', "<cmd>Rest run<cr>", { desc = "Run the request under the cursor" })
vim.keymap.set('n', '<leader>rr', "<cmd>Rest run last<cr>", { desc = "Re-Run latest request" })

-------------
-- [D]ebug --
-------------
vim.keymap.set('n', '<F5>', require('dap').continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', require('dap').step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', require('dap').step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', require('dap').step_out, { desc = 'Debug: Step Out' })
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F7>', require('dapui').toggle, { desc = 'Debug: See last session result.' })
vim.keymap.set('n', '<leader>cdb', require('dap').toggle_breakpoint, { desc = '[C]ode [D]ebug [B]reakpoint' })
vim.keymap.set('n', '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end,
    { desc = '[D]ebug: Set [B]reakpoint' })

--------------
-- [S]earch --
--------------
vim.keymap.set('n', '<leader>/', telescope_fuzzy_find_in_current_buffer, { desc = '[/] Fuzzy search in current buffer' })
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
-- vim.keymap.set('n', '<leader>sgf', require('telescope.builtin').git_files, {desc = '[S]earch [G]it [F]iles'})
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function() require('telescope.builtin').live_grep({search_dirs = {vim.fn.getcwd()  }}) end,
    { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set("n", "<leader>sb",
    function() require("telescope").extensions.file_browser.file_browser({ path = "%:p:h" }) end,
    { desc = '[S]earch in [B]rowser' })

---------
-- GIT --
---------
vim.keymap.set('n', '<leader>NG', require('neogit').open, { desc = '[N]eo[G]it' })



-- LSP ATTACHED TO BUFFER KEYBINDS
-- these will be buffer-local keybindings
-- because they only work if you have an active language server
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions', --
    callback = function(event)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(event.buf, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = event.buf, desc = '[K]Hover' })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = '[C-k]Signature help' })
        vim.keymap.set('n', '<leader>fs', vim.lsp.buf.signature_help,
            { buffer = event.buf, desc = '[f]loat [s]ignature' })

        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = event.buf, desc = '[C]ode [R]ename' })
        vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = event.buf, desc = '[F2]Rename' })

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = event.buf, desc = '[g]o to [d]efinition' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').lsp_definitions,
            { buffer = event.buf, desc = '[s]earch [d]efinition' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = event.buf, desc = '[g]o to [D]eclaration' })

        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = event.buf, desc = '[g]o to [r]eferences' })
        vim.keymap.set('n', '<leader>sr', require('telescope.builtin').lsp_references,
            { buffer = event.buf, desc = '[s]earch [r]eferences' })

        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = event.buf, desc = '[g]o to [i]mplementation' })
        vim.keymap.set('n', '<leader>si', require('telescope.builtin').lsp_implementations,
            { buffer = event.buf, desc = '[s]earch [i]mplementation' })

        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, { buffer = event.buf, desc = '[g]o to [t]ype definition' })
        vim.keymap.set('n', '<leader>st', require('telescope.builtin').lsp_type_definitions,
            { buffer = event.buf, desc = '[s]earch [t]ype' })

        vim.keymap.set('n', '<leader>ss', require('telescope.builtin').lsp_document_symbols,
            { buffer = event.buf, desc = '[s]earch [s]ymbol' })
        vim.keymap.set('n', '<leader>sws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
            { buffer = event.buf, desc = '[s]earch [w]orkspace [s]ymbol' })

        vim.keymap.set({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end,
            { buffer = event.buf, desc = '[F3]Format' })
        vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end,
            { buffer = event.buf, desc = '[C]ode [F]ormat' })
        vim.keymap.set('n', '<F4>', vim.lsp.buf.code_action, { buffer = event.buf, desc = '[F]ix [A]ction' })
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = '[C]ode [A]ction' })

    end --
})
