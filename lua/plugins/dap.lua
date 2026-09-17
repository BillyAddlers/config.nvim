-- NOTE: An experimental config for DAP (Debug Adapter Protocol)
-- I dunno why ppl wanna do cpp, just write in golang or rust lmao.
-- But hey, it's your choice.
--
-- This plugin allows you to debug your code in Neovim.
-- It's a powerful tool that can help you find and fix bugs in your code.
return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'

    -- Below is where we declare custom adapters for our debugger.
    --
    -- Refer to https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation for various debuggers.

    -- NOTE: C/C++/Rust Adapter
    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        -- Path to codelldb (expanded from ~)
        command = vim.fn.expand '~/.local/share/nvim/mason/bin/codelldb',
        args = { '--port', '${port}' },

        -- On windows you may have to uncomment this:
        -- detached = false,
      },
    }
    -- NOTE: GoLang Delve Adapter
    dap.adapters.delve = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
        -- add this if on windows, otherwise server won't open successfully
        -- detached = false
      },
    }

    -- Below is where we declare custom configurations for our debugger.
    -- This is where we specify the program to debug, the working directory, etc.
    -- You can have multiple configurations for different types of debugging.
    -- For example, you could have a configuration for debugging a server, and another for debugging a client.
    -- Most debugger config options are consuming avaiable adapters above.

    -- NOTE: C/C++ Configuration
    dap.configurations.cpp = {
      {
        name = 'Launch file',
        type = 'codelldb',
        request = 'launch',
        program = function()
          -- Try to detect the executable automatically or prompt the user
          local cwd = vim.fn.getcwd()
          local executable = cwd .. '/main' -- Adjust 'main' to your binary name
          if vim.fn.filereadable(executable) == 1 then
            return executable
          else
            return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
          end
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
    -- NOTE: GoLang Configuration
    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
      {
        type = 'delve',
        name = 'Debug',
        request = 'launch',
        program = '${file}',
      },
      {
        type = 'delve',
        name = 'Debug test', -- configuration for debugging test files
        request = 'launch',
        mode = 'test',
        program = '${file}',
      },
      -- works with go.mod packages and sub packages
      {
        type = 'delve',
        name = 'Debug test (go.mod)',
        request = 'launch',
        mode = 'test',
        program = './${relativeFileDirname}',
      },
    }
  end,
}
