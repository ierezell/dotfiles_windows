-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
require('mason').setup()
-- Setup neovim lua configuration
require('neodev').setup()
-- mason-lspconfig requires that these setup functions are called in this order

-- To add/bind autocompletion capabilities to the LSP

require('mason-lspconfig').setup(
    {
        automaric_installation = true, --
        ensure_installed = {
            "rust_analyzer@nightly", --
            "typos_lsp", --
            "pyright", --
            "lua_ls", --
            "csharp_ls", -- 
            "dockerls", -- 
            "html", --
            "jsonls", -- 
            "ruff", --
            "ruff_lsp", --
            "sqlls", --
            "tsserver" --
        }, --
        on_attach = on_attach, --
        handlers = {
            function(server)
                require('lspconfig')[server].setup(
                    { --
                        capabilities = require('cmp_nvim_lsp').default_capabilities( --
                            vim.lsp.protocol.make_client_capabilities()) --
                    })
            end}})
