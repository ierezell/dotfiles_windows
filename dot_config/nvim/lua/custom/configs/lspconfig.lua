--- This file load the lsp-plugin and allow you to override / setup. 
--- Plugin is defined in plugins.lua with {"lsp", opt={}}

local default_on_attach = require("plugins.configs.lspconfig").on_attach
local default_capabilities = require("plugins.configs.lspconfig").capabilities

--- lspconfig is lsp_plugin.opt.servers options
--- setup is lspconfig.opt.setup options
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local on_attach_with_formating = function(client, bufnr)
  default_on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.resolved_capabilities.document_formatting = true
  client.resolved_capabilities.document_range_formatting = true
end

lspconfig.pyright.setup {
  on_attach = default_on_attach,
  capabilities = default_capabilities,
  filetypes = { "python" },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach_with_formating,
  capabilities = default_capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
    },
  },
}
