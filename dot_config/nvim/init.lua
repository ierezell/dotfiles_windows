-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
        lazypath
    }
end

vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--  as they will be available in your neovim runtime.
require('lazy').setup(
    { 
        -- NOTE: First, some plugins that don't require any configuration
        -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
        --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
        --    up-to-date with whatever is in the kickstart repo.
        --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
        --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
        --
        -- [
        --     GitSigns : Adds git related signs to the gutter, as well as utilities for managing changes
        --     Debug : add debugger support
        --     AutoFormat : add autoformatting
        --     AutoPairs : add autopairs
        -- ]
        { import = 'lazy_plugins' },
        -- 
        'tpope/vim-fugitive', -- Git related plugins
        'tpope/vim-rhubarb',  -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth', 
        { 'folke/which-key.nvim', opts = {} }, -- Useful plugin to show you pending keybinds.
        { 'navarasu/onedark.nvim', priority = 1000, config = function() vim.cmd.colorscheme 'onedark' end }, -- Theme inspired by Atom
        { 'numToStr/Comment.nvim', opts = {} }, -- Highlight, edit, and navigate code
        { 'nvim-treesitter/nvim-treesitter', dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'}, build = ':TSUpdate' }, 
        -- NOTE: This is where your plugins related to LSP can be installed.
        --  The configuration is done below. Search for lspconfig to find it below.
        {
            ---------------------------------
            -- LSP Configuration & Plugins --
            ---------------------------------
            -- Automatically install LSPs to stdpath for neovim
            'neovim/nvim-lspconfig',
            dependencies = { 
                { 'williamboman/mason.nvim', config = true },
                'williamboman/mason-lspconfig.nvim', 
                -- Useful status updates for LSP
                -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
                -- Additional lua configuration, makes nvim stuff amazing!
                { 'j-hui/fidget.nvim', opts = {} }, 
                'folke/neodev.nvim'
            }
        },
        {
            --------------------
            -- Autocompletion --
            --------------------
            'hrsh7th/nvim-cmp',
            dependencies = { 
                'L3MON4D3/LuaSnip', -- Snippet Engine & its associated nvim-cmp source
                'saadparwaiz1/cmp_luasnip', -- Adds LSP completion capabilities
                'hrsh7th/cmp-nvim-lsp', 
                'hrsh7th/cmp-path', -- Adds a number of user-friendly snippets
                'rafamadriz/friendly-snippets'
            }
        }, 
        {
            -------------------------------
            -- Set lualine as statusline --
            -------------------------------
            'nvim-lualine/lualine.nvim',
            -- See `:help lualine.txt`
            opts = {
                options = {
                    icons_enabled = false,
                    theme = 'onedark',
                    component_separators = '|',
                    section_separators = ''
                }
            }
        }, 
        {
            ------------------------------------------------
            -- Add indentation guides even on blank lines --
            ------------------------------------------------
            -- "gc" to comment visual regions/lines
            'lukas-reineke/indent-blankline.nvim',
            -- See `:help ibl`
            main = 'ibl',
            opts = {}
        }, 
        {
            ------------------------------------
            -- Fuzzy Finder (files, lsp, etc) --
            ------------------------------------
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = {
                -- Fuzzy Finder Algorithm which requires local dependencies to be built.
                'nvim-lua/plenary.nvim', 
                -- Only load if `make` is available. Make sure you have the system
                -- requirements installed.
                {
                    'nvim-telescope/telescope-fzf-native.nvim',
                    -- NOTE: If you are having trouble with this installation,
                    -- refer to the README for telescope-fzf-native for more instructions.
                    build = 'make',
                    cond = function()
                        return vim.fn.executable 'make' == 1
                    end
                }
            }
        }, 
    }, 
    {}
)

-- [[ Setting options ]]
require 'settings.config'

-- [[ Basic Keymaps ]]
require 'settings.keymaps'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', { callback = function() vim.highlight.on_yank() end, group = highlight_group, pattern = '*' })

-- [[ Configure Telescope ]]
require 'settings.telescope.plugin'

-- [[ Configure Treesitter ]]
require 'settings.treesitter'

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, {
            buffer = bufnr,
            desc = desc
        })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
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
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, {
        desc = 'Format current buffer with LSP'
    })
end


require 'settings.lsp'

-- [[ Configure nvim-cmp ]]
require 'settings.completions'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
