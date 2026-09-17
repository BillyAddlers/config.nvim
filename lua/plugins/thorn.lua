-- Different theme testing
return {
  'jpwol/thorn.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    theme = nil, -- 'light' or 'dark' - defaults to vim.o.background if unset

    transparent = true, -- transparent background
    terminal = true, -- terminal colors
  },
  init = function()
    -- Init this command to apply colorscheme
    vim.cmd [[colorscheme thorn]]
  end,
}
