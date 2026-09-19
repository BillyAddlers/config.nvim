return {
  'CopilotC-Nvim/CopilotChat.nvim', -- Copilot Chat
  branch = 'canary',
  keys = {
    { '<leader>cc', '<cmd>CopilotChatToggle <CR>', desc = 'Copilot Chat', mode = { 'n', 'v' } },
  },
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
