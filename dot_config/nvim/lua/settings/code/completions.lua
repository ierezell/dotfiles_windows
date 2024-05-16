-- See `:help cmp`
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup(
    {
        sources = {{name = 'nvim_lsp'}, {name = 'path'}}, --
        mapping = cmp.mapping.preset.insert(
            {
                ['<CR>'] = cmp.mapping.confirm({select = false}), -- Enter key confirms completion item
                ['<C-Space>'] = cmp.mapping.complete() -- Ctrl + space triggers completion menu
            } --
        ), --
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end --
        } --
    } --
) --
