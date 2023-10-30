local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  {
    "nvim-telescope/telescope.nvim",
    opts={
      file_ignore_patterns = { "typings/pylance-stubs-unofficial","pylance-stubs-unofficial", "poetry.lock" },
    }
  },
  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- web
        "html-lsp",
        "prettier",
        -- lua
        "lua-language-server",
        "stylua",
        --python
        "black",
        "sourcery",
        "mypy",
        "ruff",
        "ruff-lsp",
        "autopep8",
        "flake8",
        "pyright",
        "isort",
        "pyre",

        --rust
        "rust-analyzer",

        --misc
        "cspell",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "python",
        "terraform",
        "rust",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
  },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "mfussenegger/nvim-dap",
  },

  {
    "mfussenegger/nvim-dap-python",
  },

  {
    "rcarriga/nvim-dap-ui",
  },

  {
    "hashivim/vim-terraform.git",
  },
  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
