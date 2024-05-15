--------------------
-- Autocompletion --
--------------------
return {
    'hrsh7th/nvim-cmp',
    dependencies = {'L3MON4D3/LuaSnip', -- Snippet Engine & its associated nvim-cmp source
    'saadparwaiz1/cmp_luasnip', -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets'}
}
