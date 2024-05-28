return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    "antosha417/nvim-lsp-file-operations",
    "nvim-tree/nvim-web-devicons",
    'b0o/nvim-tree-preview.lua',
  },
  config = function()
    require("nvim-tree").setup {}
    require("lsp-file-operations").setup()
    require("nvim-tree-preview").setup()
  end,
}
