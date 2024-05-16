local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
dashboard.section.header.val = {
    [[                                   __                ]],
    [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]], [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]]
}

dashboard.section.buttons.val = {
    dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", "  > Find file", ":cd /mnt/data | Telescope find_files<CR>"),
    dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    dashboard.button("g", "  > Grep", ":Telescope live_grep<CR>"),
    dashboard.button("m", "  > Marks", ":Telescope marks<CR>"),
    dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
    dashboard.button("q", "  > Quit NVIM", ":qa<CR>")
}

alpha.setup(dashboard.config)
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
