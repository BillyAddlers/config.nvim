return {
  'RRethy/base16-nvim',
  lazy = false,
  priority = 1000,
  enabled = true,
  config = function()
    require('matugen').setup()
  end,
}
