local null_ls = require "null-ls"

local sources = {

  -- webdev stuff
  -- choosed deno for ts/js files cuz its very fast!
  null_ls.builtins.formatting.deno_fmt,
  -- so prettier works only on these filetypes
  null_ls.builtins.formatting.prettier.with {
    filetypes = { "html", "markdown", "css" },
  },

  -- Lua
  null_ls.builtins.formatting.stylua,

  -- cpp
  null_ls.builtins.formatting.clang_format,

  -- python
  null_ls.builtins.diagnostics.mypy,
  null_ls.builtins.diagnostics.ruff,
  null_ls.builtins.diagnostics.black,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
