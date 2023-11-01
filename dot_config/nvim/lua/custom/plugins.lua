local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  --- Default Core plugins
  -- {
  --   "nvim-lua/plenary.nvim",
  --   "NvChad/base46",
  --   "NvChad/ui",
  --   "NvChad/nvterm",
  --   "NvChad/nvim-colorizer.lua",
  --   "nvim-tree/nvim-web-devicons",
  --   "lukas-reineke/indent-blankline.nvim",
  --   "nvim-treesitter/nvim-treesitter",
  --   "lewis6991/gitsigns.nvim",
  --   "williamboman/mason.nvim",
  --   "neovim/nvim-lspconfig",
  --   "hrsh7th/nvim-cmp",
  --   "L3MON4D3/LuaSnip",
  --   "rafamadriz/friendly-snippets",
  --   "windwp/nvim-autopairs",
  --   "saadparwaiz1/cmp_luasnip",
  --   "hrsh7th/cmp-nvim-lua",
  --   "hrsh7th/cmp-nvim-lsp",
  --   "hrsh7th/cmp-buffer",
  --   "hrsh7th/cmp-path",
  --   "numToStr/Comment.nvim",
  --   "nvim-tree/nvim-tree.lua",
  --   "nvim-telescope/telescope.nvim",
  --   "nvim-treesitter/nvim-treesitter",
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   "folke/which-key.nvim",
  -- },

  { "hashivim/vim-terraform" },

  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },

  { "simrat39/rust-tools.nvim", ft = { "rust" } },

  { "lewis6991/gitsigns.nvim", opts = overrides.gitsigns },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-python", "rouge8/neotest-rust" },
    opts = {
      adapters = {
        ["neotest-python"] = {
          runner = "pytest",
          python = ".venv/bin/python",
        },
        ["neotest-rust"] = {},
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Exafunction/codeium.vim",
        cmd = "Codeium",
        build = ":Codeium Auth",
        event = "BufEnter",
      },
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = { src = { cmp = { enabled = true } } },
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        config = function()
          local path = require("mason-registry").get_package("debugpy"):get_install_path()
          require("dap-python").setup(path .. "/venv/bin/python")
        end,
      },

      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },

      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
    config = function()
      require "custom.configs.dap"
    end,
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
    opts = function()
      local ok, mason_registry = pcall(require, "mason-registry")
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package "codelldb"
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = ""
        if vim.loop.os_uname().sysname:find "Windows" then
          liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
        elseif vim.fn.has "mac" == 1 then
          liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
        else
          liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        end
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = { adapter = adapter },
        tools = {
          runnables = { use_telescope = true },
          inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
          },
          on_initialized = function()
            vim.cmd [[
              augroup RustLSP
                autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
              augroup END
            ]]
          end,
        },
      }
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-lua/plenary.nvim",
      { "folke/trouble.nvim", opts = { use_diagnostic_signs = true } },
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
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "williamboman/mason.nvim" },
    lazy = false,
    -- "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "custom.configs.none-ls"
      -- require "custom.configs.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "nvimtools/none-ls.nvim" },
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
        virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = { enabled = false },
      -- add any global capabilities here
      capabilities = {},
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = { formatting_options = nil, timeout_ms = nil },
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

        -- debug
        "debugpy",
        "codelldb",

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
        "hcl",
        "terraform",
        "rust",
        "ron",
        "toml",
      },
    },
  },
}

return plugins
