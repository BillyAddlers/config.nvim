-- NOTE: A Note-taking plugins.
-- Replacing default note-taking feature from Telescope.
return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.concealer'] = {}, -- Adds pretty icons to your documents
        ['core.dirman'] = { -- Manages Neorg workspaces
          config = {
            -- Feel free to add workspaces, `notes` are on home directory inside `.notes`.
            workspaces = {
              notes = '~/.notes',
            },
            default_workspace = 'notes',
          },
        },
      },
    }
  end,
}
