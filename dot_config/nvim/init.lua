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
    'tpope/vim-fugitive',                                                                                    -- Git related plugins
    'tpope/vim-rhubarb',                                                                                     -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    { 'folke/which-key.nvim',            opts = {} },                                                        -- Useful plugin to show you pending keybinds.
    { 'navarasu/onedark.nvim',           priority = 1000,                                                config = function()
      vim.cmd.colorscheme 'onedark' end },                                                                   -- Theme inspired by Atom
    { 'numToStr/Comment.nvim',           opts = {} },                                                        -- Highlight, edit, and navigate code
    { 'nvim-treesitter/nvim-treesitter', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }, build = ':TSUpdate' },
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
        { 'j-hui/fidget.nvim',       opts = {} },
        'folke/neodev.nvim'
      }
    },
    {
      --------------------
      -- Autocompletion --
      --------------------
      'hrsh7th/nvim-cmp',
      dependencies = {
        'L3MON4D3/LuaSnip',                 -- Snippet Engine & its associated nvim-cmp source
        'saadparwaiz1/cmp_luasnip',         -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',                 -- Adds a number of user-friendly snippets
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
vim.api.nvim_create_autocmd('TextYankPost',
  { callback = function() vim.highlight.on_yank() end, group = highlight_group, pattern = '*' })

-- [[ Configure Telescope ]]
require 'settings.telescope.plugin'

-- [[ Configure Treesitter ]]
require 'settings.treesitter'

-- [[ Configure LSP ]]

require 'settings.lsp'

-- [[ Configure nvim-cmp ]]
require 'settings.completions'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
