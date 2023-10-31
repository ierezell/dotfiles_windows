local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  {
    "nvim-telescope/telescope.nvim",
    opts = {
      file_ignore_patterns = { "typings/pylance-stubs-unofficial", "pylance-stubs-unofficial", "poetry.lock" },
    },
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

  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  { "simrat39/rust-tools.nvim", ft = { "rust" } },

  {
    "rust-lang/rust.vim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  { "mfussenegger/nvim-dap" },

  { "mfussenegger/nvim-dap-python" },

  { "rcarriga/nvim-dap-ui" },

  { "hashivim/vim-terraform" },
  { "Exafunction/codeium.vim", event = "BufEnter" },

  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    init = function()
      require("telescope").load_extension "lazygit"
    end,
  },

  { "nvim-lua/plenary.nvim", rm_default_opts = true },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen" }, -- add more commands here
    config = function()
      require("diffview").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}

return plugins
