-- NOTE: A Neovim-based live-share plugin for live collaboration
-- Based on instant.nvim, forwarded using serveo.net/localhost.run
return {
  'azratul/live-share.nvim',
  dependencies = {
    'jbyuki/instant.nvim',
  },
  config = function()
    vim.g.instant_username = 'your-username'
    require('live-share').setup {
      port_internal = 9876, -- The local port to be used for the live share connection
      max_attempts = 20, -- Maximum number of attempts to read the URL from service(serveo.net or localhost.run), every 250 ms
      service_url = '/tmp/service.url',
      service = 'nokey@localhost.run', -- Service to use, options are serveo.net or localhost.run
    }
  end,
}
