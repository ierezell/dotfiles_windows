local none_ls = require "null-ls"

local sources = {

  -- webdev stuff
  -- so prettier works only on these filetypes
  none_ls.builtins.formatting.prettier.with {
    filetypes = { "html", "markdown", "css" },
  },

  -- Lua
  none_ls.builtins.formatting.stylua,

  -- git
  none_ls.builtins.code_actions.gitsigns,

  -- spell 
  none_ls.builtins.completion.spell,

  -- python
  -- none_ls.builtins.diagnostics.mypy,
  none_ls.builtins.diagnostics.ruff,
  none_ls.builtins.formatting.black,
  -- none_ls.builtins.formatting.isort,
  none_ls.builtins.formatting.terraform_fmt,
  none_ls.builtins.diagnostics.terraform_validate,
}

none_ls.setup {
  debug = true,
  sources = sources,
}
