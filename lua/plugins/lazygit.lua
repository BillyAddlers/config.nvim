-- NOTE: You can never get lazier, even if it's NeoVim!
--  LazyGit is a plugin that allows you to use Git commands in a more visual way.
return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  -- optional for floating window border decoration
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { '<leader>g', '<cmd>LazyGit<cr>', desc = '[L]azy [G]it' },
  },
}
