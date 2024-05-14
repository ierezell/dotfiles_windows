-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
-- https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- You can configure plugins using the `config` key.
-- You can also configure plugins after the setup call,
-- as they will be available in your neovim runtime.
require('lazy').setup(
  {
    { import = 'lazy_plugins' },
    'tpope/vim-fugitive',                             -- Git related plugins
    'tpope/vim-rhubarb',                              -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    { 'folke/which-key.nvim',            opts = {} }, -- Useful plugin to show you pending keybinds.
    { 'numToStr/Comment.nvim',           opts = {} }, -- Highlight, edit, and navigate code
    { 'nvim-treesitter/nvim-treesitter', dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }, build = ':TSUpdate' },
    {
      'goolord/alpha-nvim', -- Start-up menu
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        dashboard.section.header.val = {
          [[                                   __                ]],
          [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
          [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
          [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
          [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
          [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        }

        dashboard.section.buttons.val = {
          dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
          dashboard.button("f", "  > Find file", ":cd /mnt/data | Telescope find_files<CR>"),
          dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
          dashboard.button("g", "  > Grep", ":Telescope live_grep<CR>"),
          dashboard.button("m", "  > Marks", ":Telescope marks<CR>"),
          dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
          dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
        }

        alpha.setup(dashboard.config)
        vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
      end
    },
    {
      -- Float or stack terminal
      {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
          size = 20 | function(term)
            if term.direction == "horizontal" then
              return 15
            elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end,
          open_mapping = [[<c-`>]]
        }
      }
    },
    {
      'navarasu/onedark.nvim', -- Theme inspired by Atom
      priority = 1000,
      config = function()
        vim.cmd.colorscheme 'onedark'
      end
    },
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
        'folke/neodev.nvim',
        { 'j-hui/fidget.nvim',       opts = {} },
      }
    },
    {
      --------------------
      -- Autocompletion --
      --------------------
      'hrsh7th/nvim-cmp',
      dependencies = {
        'L3MON4D3/LuaSnip',         -- Snippet Engine & its associated nvim-cmp source
        'saadparwaiz1/cmp_luasnip', -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',         -- Adds a number of user-friendly snippets
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
