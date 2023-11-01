local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  { "nvim-lua/plenary.nvim" },

  { "mfussenegger/nvim-dap-python", ft = "python" },

  { "hashivim/vim-terraform" },

  { "Exafunction/codeium.vim", event = "BufEnter" },

  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

  {"nvimtools/none-ls.nvim"},

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
      end
    end,
  },

  { "simrat39/rust-tools.nvim", ft = { "rust" } },

  { "lewis6991/gitsigns.nvim", opts = overrides.gitsigns },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          src = {
            cmp = { enabled = true },
          },
        },
      },
    },
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "crates" } }))
    end,
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      src = {
        cmp = { enabled = true },
      },
    },
  },

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
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },

  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local theme = require "alpha.themes.startify"
      theme.mru_opts.autocd = true
      require("alpha").setup(theme.config)
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
    opts = {
      tools = {
        runnables = { use_telescope = true },
        inlay_hints = {
          auto = true,
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    build = "make",
    opts = { use_diagnostic_signs = true },
    config = function(_, opts)
      require("telescope").load_extension "fzf"

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
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.none-ls"
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
