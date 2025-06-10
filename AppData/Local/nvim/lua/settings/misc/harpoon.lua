local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = '[H]arpoon [A]dd'})
vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end, {desc = '[H]arpoon [L]ist'})
vim.keymap.set("n", "<leader>lh", function() toggle_telescope(harpoon:list()) end, {desc = '[L]ist [Harpoon]'})

vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, {desc = '[H]arpoon 1'})
vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, {desc = '[H]arpoon 2'})
vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, {desc = '[H]arpoon 3'})
vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, {desc = '[H]arpoon 4'})
vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end, {desc = '[H]arpoon 5'})

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hn", function() harpoon:list():prev() end, {desc = '[H]arpoon [N]ext'})
vim.keymap.set("n", "<leader>hp", function() harpoon:list():next() end, {desc = '[H]arpoon [P]revious'})

