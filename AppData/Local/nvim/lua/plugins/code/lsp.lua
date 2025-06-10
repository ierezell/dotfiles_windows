return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        'folke/neodev.nvim', 
        {'j-hui/fidget.nvim', opts = {}}
    }
}