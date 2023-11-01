local none_ls = require "none-ls"

local sources = {

  -- webdev stuff
  -- choosed deno for ts/js files cuz its very fast!
  none_ls.builtins.formatting.deno_fmt,
  -- so prettier works only on these filetypes
  none_ls.builtins.formatting.prettier.with {
    filetypes = { "html", "markdown", "css" },
  },

  -- Lua
  none_ls.builtins.formatting.stylua,

  -- cpp
  none_ls.builtins.formatting.clang_format,

  -- python
  -- none_ls.builtins.diagnostics.mypy,
  none_ls.builtins.diagnostics.ruff,
  none_ls.builtins.formatting.black,
}

none_ls.setup {
  debug = true,
  sources = sources,
}
