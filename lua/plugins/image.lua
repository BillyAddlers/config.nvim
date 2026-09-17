-- NOTE: A plugin to display images in Neovim.
-- I installed both image_preview.nvim which uses kitty terminal under the hood,
-- and image.nvim which uses ImageMagick with magick.nvim bindings.
--
-- We'll test which one is stable and better for our use case.
--
-- UPDATE: image.nvim is stable and will be used from now on!
-- Feel free to fallback to image_preview.nvim if your platform is incompatible with image.nvim
-- {
--   'adelarsq/image_preview.nvim',
--   event = 'VeryLazy',
--   config = function()
--     require('image_preview').setup()
--   end,
-- },
--
-- NOTE: image.nvim is a plugin that allows you to display images in Neovim.
-- Visit [This github link](https://github.com/3rd/image.nvim) for basic backend installation.
-- ImageMagick is required for this plugin to work.
--
-- [magick.nvim](https://github.com/kiyoon/magick.nvim) is added as a dependency to reduce the hassle of installing magick Luarock.
-- And since MacOS/Arch Linux's default Luarock version is 5.4 and magick doesn't support >5.1, we'll use magick.nvim as a workaround.
return {
  '3rd/image.nvim',
  event = 'VeryLazy',
  dependencies = {
    'kiyoon/magick.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    backend = 'kitty',
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
      },
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { 'norg' },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 75,
    tmux_show_only_in_active_window = false,
    kitty_method = 'normal',
    hijack_file_patterns = { '*.svg', '*.png', '*.jpg', '*.jpeg', '*.gif', '*.bmp', '*.ico', '*.webp' },
  },
}
