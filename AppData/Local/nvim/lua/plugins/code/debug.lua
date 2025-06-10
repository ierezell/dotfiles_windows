-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)
return {
    -- NOTE: Yes, you can install new plugins here!
    'mfussenegger/nvim-dap', -- NOTE: And you can specify dependencies as well
    dependencies = {
        'nvim-neotest/nvim-nio', -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui', -- Installs the debug adapters for you
        -- 'williamboman/mason.nvim', --
        'jay-babu/mason-nvim-dap.nvim', -- Add your own debuggers here
        'leoluz/nvim-dap-go'
    }
}
