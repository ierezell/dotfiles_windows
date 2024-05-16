return {
    -- Automatically install LSPs to stdpath for neovim
    'neovim/nvim-lspconfig', dependencies = {
        {'williamboman/mason.nvim', config = true}, 'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim', {'j-hui/fidget.nvim', opts = {}}
    }
}
