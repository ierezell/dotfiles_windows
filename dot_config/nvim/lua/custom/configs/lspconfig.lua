local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table

local on_attach_with_formating = function(client, bufnr)
  on_attach(client, bufnr)
  client.resolved_capabilities.document_formatting = true
  client.server_capabilities.documentFormattingProvider = true
  client.resolved_capabilities.document_range_formatting = true
end

lspconfig.null_ls.setup {
  on_attach = on_attach_with_formating,
  capabilities = capabilities,
}

lspconfig.pyright.setup {
  on_attach = on_attach_with_formating,
  capabilities = capabilities,
  filetypes = { "python" },
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach_with_formating,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = { ["rust-analyzer"] = { cargo = { allFeatures = true } } },
}
