-- NOTE: nvim-tree to navigate through project structure.
-- See `:help nvim-tree` for more information
--
-- It give sense of having an actuall full fledged IDE
return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- NOTE: Adding custom keymaps for nvim-tree
    -- See `:help nvim-tree.lua` for more information
    --
    -- The following keymaps are used to toggle the tree, find the current file, and refresh the tree.
    --
    -- vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle [E]xplorer' })
    -- WARN: We're moving filesystem manager to neotree for image preview support.
    -- nvim-tree exist to provide fallback if neotree goes wrong.
    require('nvim-tree').setup {
      update_focused_file = {
        enable = true,
      },
      view = {
        width = 40,
        side = 'left',
      },
      renderer = {
        highlight_opened_files = 'all',
        highlight_git = true,
        root_folder_modifier = ':t',
        indent_markers = {
          enable = true,
        },
        full_name = true,
      },
    }
  end,
}
