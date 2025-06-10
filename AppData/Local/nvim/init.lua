-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Package manager
-- [[ Install `lazy.nvim` plugin manager ]]
-- https://github.com/folke/lazy.nvim
-- `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath
    }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]

-- ALL PLUGINS SHOULD BE IN THE plugins/ folder
-- IF SUBFOLDER IS USED SOURCE IT IN THE init.lua

-- You can configure plugins using the `config` key.
-- You can also configure plugins after the setup call,
-- as they will be available in your neovim runtime.
-- E.G
-- require('lazy').setup({{
--     import = 'plugins' // Import a folder of plugins where all .lua files needs to be as bellow
--     {                  // or return {} if in a .lua file. 
--         "PluginName",
--         dependencies = {'PluginDependencyName'},
--         config = function() // Usually a function but opts={} could be used
--             local plugin = require("PluginName").setup {}
--             plugin.option = values etc....
--         end
--     }
-- }})

require('lazy').setup 'plugins'

require 'settings'
