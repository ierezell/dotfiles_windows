-- See `:help cmp`
local cmp = require('cmp')

cmp.setup(
    {
        sources = {
            { name = 'codeium' },
            { name = 'nvim_lsp' },
            { name = 'path' }
        }, --
        mapping = cmp.mapping.preset.insert(
            {
                ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Enter key confirms completion item
                ['<C-Space>'] = cmp.mapping.complete()              -- Ctrl + space triggers completion menu
            }                                                       --
        ),                                                          --
    }
)
