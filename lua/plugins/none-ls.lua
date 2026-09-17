-- NOTE: Null-ls is a plugin that allows you to use LSP features without an LSP server.
-- It's a great way to get started with LSP features without needing to install a server.
-- It also offer integration between LSP and other tools like prettier, eslint, etc.
return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VeryLazy',
    config = function()
      require('null-ls').setup {
        sources = {
          require('null-ls').builtins.formatting.prettier,
          require('null-ls').builtins.formatting.gofumpt,
          require('null-ls').builtins.formatting.goimports,
          require('null-ls').builtins.formatting.gofmt,
          require('null-ls').builtins.formatting.clang_format,
        },
      }
    end,
  },
  -- Ensure dependencies are also included
  { 'nvim-lua/plenary.nvim' }, -- Dependency for null-ls
}
