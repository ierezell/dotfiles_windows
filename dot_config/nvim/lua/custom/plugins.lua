local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  { "nvim-lua/plenary.nvim" },

  { "mfussenegger/nvim-dap-python", ft = "python" },

  { "hashivim/vim-terraform" },

  { "Exafunction/codeium.vim", event = "BufEnter" },

  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

  { "simrat39/rust-tools.nvim", ft = { "rust" } },

  { "lewis6991/gitsigns.nvim", opts = overrides.gitsigns },

  { "hrsh7th/nvim-cmp", opts = overrides.cmp },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require "custom.configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
    requires = { "mfussenegger/nvim-dap" },
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
    requires = { "mfussenegger/nvim-dap" },
  },

  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    config = function(_, opts)
      --- local actions = require "telescope.actions"
      local trouble = require "trouble.providers.telescope"
      opts.defaults.mappings = {
        i = { ["<c-o>"] = trouble.open_with_trouble },
        n = { ["<c-o>"] = trouble.open_with_trouble },
      }
      require("telescope").setup(opts)
    end,
  },

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

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen" },
    config = function()
      require("diffview").setup()
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle" },
  },

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
    end,
  },

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
}

return plugins
