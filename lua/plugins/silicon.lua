-- NOTE: A plugin to generate beautiful images of your code.
--
-- REMEMBER: The true Text Editor is Vim/Neovim!
return {
  'michaelrommel/nvim-silicon',
  lazy = true,
  cmd = 'Silicon',
  -- PINNED: `pin = true` keeps `:Lazy update` from checking out a newer commit,
  -- which would revert the local `vim.validate` deprecation fix applied in
  -- `~/.local/share/nvim/lazy/nvim-silicon/lua/nvim-silicon/init.lua`.
  -- `commit` makes a fresh install land on this exact revision.
  -- Remove both once upstream ships the fix, then `:Lazy update`.
  -- Upstream: https://github.com/michaelrommel/nvim-silicon
  commit = '7f66bda8f60c97a5bf4b37e5b8acb0e829ae3c32',
  pin = true,
  -- Setting custom keymaps for Silicon. Declared with `keys` so the plugin is
  -- only loaded once one of them is pressed.
  keys = {
    {
      '<leader>sc',
      function()
        require('nvim-silicon').clip()
      end,
      mode = 'v',
      desc = 'Copy [S]ilicon render to [c]lipboard',
    },
    {
      '<leader>sf',
      function()
        require('nvim-silicon').file()
      end,
      mode = 'v',
      desc = 'Save [S]ilicon render to [f]ile',
    },
    {
      '<leader>ss',
      function()
        require('nvim-silicon').shoot()
      end,
      mode = 'v',
      desc = 'Take a [S]ilicon [s]creenshot',
    },
  },

  -- Setting up Silicon with some custom configuration.
  -- Randomized color from the custom function defined above.
  config = function()
    require('nvim-silicon').setup {
      no_line_number = true,

      -- Font used.
      -- Feel free to change the fonts accordingly.
      font = 'JetBrainsMono Nerd Font',
      -- Theme used in Silicon rendering.
      theme = 'Dracula',

      -- Setup padding for the image.
      pad_horiz = 100,
      pad_vert = 120,

      -- Randomized color for the background.
      background = vim.api.nvim_get_silicon_color(),

      -- NOTE: We will use this to set watermark text in the image.
      -- At least until nvim-silicon decided to support watermarking.
      --
      -- Another alternative is to use background_image as a watermark.
      -- Just point directly at an image, or use a function to generate a path.
      --
      -- background_image = '/path/to/background.png',
      -- background_image = function()
      --  return vim.fn.stdpath('config') .. 'background.png'
      -- end,
      --
      -- See `:help silicon` for more information.
      window_title = function()
        -- WARN: Don't forget to change the watermark, otherwise it will be the same as mine.
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ':t') .. ' by  @billyaddlers'
      end,
    }
  end,
}
