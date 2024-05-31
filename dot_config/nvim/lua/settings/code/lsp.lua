-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
require('mason').setup()
-- Setup neovim lua configuration
require('neodev').setup()
-- mason-lspconfig requires that these setup functions are called in this order

-- To add/bind autocompletion capabilities to the LSP
local navic = require("nvim-navic")
local lsp_on_attach = function(client, bufnr)
    	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end
end

require('mason-lspconfig').setup(
    {
        automaric_installation = true, --
        ensure_installed = {
            "rust_analyzer@nightly", --
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
        -- on_attach done in keybindings. 
        handlers = {
            function(server)
                require('lspconfig')[server].setup(
                    { --
			on_attach = lsp_on_attach,
                        capabilities = require('cmp_nvim_lsp').default_capabilities( --
                            vim.lsp.protocol.make_client_capabilities()) --
                    })
            end --
        } --
    } --
)
