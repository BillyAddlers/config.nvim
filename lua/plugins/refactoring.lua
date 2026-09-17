-- NOTE: A plugin to help with refactoring code.
-- This plugin allows you to easily refactor your code.
--
-- It's a great way to quickly make changes to your code without having to do it manually.
-- ThePrimeagen makes something good other than Harpoon2.
return {
  'ThePrimeagen/refactoring.nvim',
  lazy = false,
  dependencies = {
    --  It seems refactoring.nvim has less dependencies now.
    --  Disabling those.
    --
    --  'nvim-lua/plenary.nvim',
    --  'nvim-treesitter/nvim-treesitter',
    'lewis6991/async.nvim',
  },
  config = function()
    require('refactoring').setup {
      -- Optional: additional configuration
    }
    vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
      require('refactoring').select_refactor()
    end, { desc = 'Advanced [R]efactoring' })
  end,
}
