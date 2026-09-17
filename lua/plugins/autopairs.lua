-- NOTE: A plugin to help with autopairing brackets, quotes, etc.
-- Simple but strong!
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {}
    -- Adding cmp autopairs
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {})
  end,
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
}
