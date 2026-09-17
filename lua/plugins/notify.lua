-- NOTE: Configuring nvim-notify because it kept throwing warnings
return {
  'rcarriga/nvim-notify',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  init = function()
    local notify = require 'notify'

    -- Replacing default vim.notify with nvim-notify
    vim.notify = notify
  end,
  opts = {
    background_colour = '#1e1e1e', -- Darker background color
    timeout = 5000, -- Adjust timeout for notifications
    stages = 'fade', -- Customize animation stages if needed
  },
}
