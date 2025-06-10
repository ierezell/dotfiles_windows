require('neodev').setup()

-- To add/bind autocompletion capabilities to the LSP
local navic = require("nvim-navic")
local lsp_on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end

    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, {
            buffer = bufnr,
            desc = desc
        })
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    
    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [d]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [r]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    
    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    
    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', 
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 
        '[W]orkspace [L]ist Folders'
    )

    -- Create a command `:Format` local to the LSP buffer
    nmap('<leader>cf', function() vim.lsp.buf.format { async = true } end, '[c]ode [f]ormat')
    vim.api.nvim_buf_create_user_command(
        bufnr, 'Format', 
        function(_) vim.lsp.buf.format() end, 
        { desc = 'Format current buffer with LSP' }
    )
end

vim.lsp.config("*", {
  capabilities = vim.lsp.protocol.make_client_capabilities(), 
  on_attach = lsp_on_attach,
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)