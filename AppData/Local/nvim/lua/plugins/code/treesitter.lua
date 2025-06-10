return {
    'nvim-treesitter/nvim-treesitter', dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
    build = ':TSUpdate'
} -- To parse the code and give intellisense
