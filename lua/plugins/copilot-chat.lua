return {
  'CopilotC-Nvim/CopilotChat.nvim', -- Copilot Chat
  branch = 'canary',
  init = function()
    local copilot = require 'CopilotChat'
    local keymap = require 'which-key'
    keymap.add {
      mode = { 'n', 'v' },
      { '<leader>cc', '<cmd>CopilotChatToggle <CR>', desc = 'Copilot Chat' },
    }
  end,
  dependencies = {
    'github/copilot.vim',
    'nvim-lua/plenary.nvim', -- for curl, log wrapper
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {
    debug = false, -- Enable debugging
    -- See Configuration section for rest
  },
}
