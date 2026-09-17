return {
  'rcarriga/nvim-dap-ui',
  event = 'VeryLazy',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
  },
  keys = {
    {
      '<leader>cu',
      function()
        require('dapui').toggle()
      end,
      desc = '[C]ode DAP [U]I',
    },
    {
      '<leader>cb',
      function()
        require('dap').toggle_breakpoint() -- NOTE: Toggle breakpoint
      end,
      desc = '[C]ode DAP [B]reakpoints',
    },
    {
      '<leader>ce',
      function()
        require('dap').repl.open()
      end,
      desc = '[C]ode DAP R[e]pl',
    },
    {
      '<leader>cr',
      function()
        require('dap').continue()
      end,
      desc = '[C]ode DAP [R]un',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}
