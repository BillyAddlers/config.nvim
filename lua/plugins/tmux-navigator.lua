-- NOTE: A plugin to navigate between tmux panes and vim splits.
-- See `:help vim-tmux-navigator` for more information.
-- This plugin allows you to use the same keybinds to navigate between tmux panes and vim splits.
-- This is especially useful if you use tmux and vim together.
return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', desc = 'Navigate left (tmux / split)' },
    { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>', desc = 'Navigate down (tmux / split)' },
    { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>', desc = 'Navigate up (tmux / split)' },
    { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>', desc = 'Navigate right (tmux / split)' },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>', desc = 'Navigate to previous pane / split' },
  },
}
