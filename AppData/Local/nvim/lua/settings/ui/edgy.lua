local edgy = require("edgy")

edgy.setup({
    bottom = {
      -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
      {
        ft = "toggleterm",
        size = { height = 0.4 },
        -- exclude floating windows
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
      {
        ft = "help",
        size = { height = 20 },
        -- only show help buffers
        filter = function(buf)
          return vim.bo[buf].buftype == "help"
        end,
      },
    },
    left = {
      -- {
      --   title = "Symbols",  
      --   ft = "trouble",
      --   pinned = true,
      --   open = "Trouble symbols"
      --   
      -- },
      -- {ft = "trouble"},
      {ft = "NvimTree"}
    },
  }
)
