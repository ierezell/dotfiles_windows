---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>tt"] = { ":TroubleToggle <CR>", "toggle trouble" },
    ["<leader>tw"] = { ":TroubleToggle workspace_diagnostics <CR>", "toggle trouble workspace" },
    ["<leader>td"] = { ":TroubleToggle document_diagnostics <CR>", "toggle trouble document" },
    ["<leader>tq"] = { ":TroubleToggle quickfix <CR>", "toggle trouble quickfix" },
    ["<leader>tl"] = { ":TroubleToggle loclist <CR>", "toggle trouble loclist" },
    ["gR"] = { ":TroubleToggle lsp_references <CR>", "toggle trouble references" },
    ["<leader>gg"] = { ":LazyGit <CR>", "open lazygit" },
    ["<leader>dPt"] = {
      function()
        require("dap-python").test_method()
      end,
      "Debug Method",
    },
    ["<leader>dPc"] = {
      function()
        require("dap-python").test_class()
      end,
      "Debug Class",
    },
  },
  v = { [">"] = { ">gv", "indent" } },
}

-- more keybinds!

return M
