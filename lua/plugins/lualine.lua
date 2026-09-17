return { -- Statusline bottom-side
  -- NOTE: Will use heirline.nvim someday, for now I'll stick with lualine.
  -- Go check https://github.com/rebelot/heirline.nvim if you wanna hop in first.
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      sections = {
        lualine_x = {
          'aerial',
          -- @diagnostic disable-next-line: undefined-field
          {
            require('noice').api.status.command.get,
            cond = require('noice').api.status.command.has,
            color = { fg = '#ff9e64' },
          },
          -- @diagnostic disable-next-line: undefined-field
          {
            require('noice').api.status.mode.get,
            cond = require('noice').api.status.mode.has,
            color = { fg = '#ff9e64' },
          },
          -- @diagnostic disable-next-line: undefined-field
          {
            require('noice').api.status.search.get,
            cond = require('noice').api.status.search.has,
            color = { fg = '#ff9e64' },
          },
          'encoding',
          'fileformat',
          'filetype',
        },
      },
      options = {
        icons_enabled = true,
        theme = 'auto',
        -- theme = 'thorn',
        -- theme = 'catppuccin', -- was 'horizon' before
      },
      extensions = {
        'nvim-tree',
        'neo-tree',
      },
    }
  end,
}
