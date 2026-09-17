return { -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command in the config to whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  -- 'folke/tokyonight.nvim',
  'catppuccin/nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- vim.cmd.colorscheme 'tokyonight-night'
    vim.cmd.colorscheme 'catppuccin-frappe'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
  config = function()
    -- You can configure the colorscheme here.
    -- For example, you can set the background to be darker or lighter.
    require('catppuccin').setup {
      transparent_background = true,
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        neotree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = '',
        },
      },
    }
  end,
}
