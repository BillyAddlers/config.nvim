-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ General Settings ]]
-- NOTE: You can change these settings as you wish!
-- GoLang specific settings
vim.g.go_fmt_command = 'gofumpt'
vim.g.go_auto_type_info = 1

-- Autoformat on save
-- Using 'conform' for autoformatting code.
-- vim.cmd [[autocmd BufWritePre *.go,*.ts,*.tsx lua vim.lsp.buf.format({async = true})]]

-- Disable border highlights background for Neotree
-- Force floating windows to have a transparent background
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE', ctermbg = 'NONE' })

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enabling termguicolors
vim.opt.termguicolors = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Default Tab Width ]]
-- Set the default tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- [[ Go-specific Indentation Setting ]]
-- See `:help lua-guide-autocommands`
--
-- This line adds an autocommand that sets the tabstop, shiftwidth, and expandtab for Go files.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

-- [[ Basic Keybind Navigation ]]
-- A custom keybind to ease navigation in the editor.

-- [[ Custom Functions ]]
-- A custom function to randomize the color of the silicon image.
-- Plugin is installed later in the config.
vim.api.nvim_get_silicon_color = function()
  local hex = '0123456789ABCDEF'
  local color = '#'

  for i = 1, 6 do
    local index = math.random(1, #hex)
    color = color .. hex:sub(index, index)
  end

  return color
end

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
--
--  Every plugin is modularized into its own file under `lua/plugins/`,
--  imported below with `{ import = 'plugins.<name>' }`. Each file returns
--  either a single plugin spec or a list of specs.
--
--  To add a new plugin:
--    1. Create `lua/plugins/<name>.lua` returning a plugin spec
--       (see `:help lazy.nvim-structuring-your-plugins`).
--    2. Add a matching `{ import = 'plugins.<name>' }` line to the list below.
require('lazy').setup({
  -- NOTE: Loading the icon plugins early to prevent any issues with icons.
  -- Most plugins below this will uses icons a lot.
  -- {
  --   'yamatsum/nvim-nonicons',
  --   lazy = false,
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     require('nvim-nonicons').setup()
  --   end,
  -- },

  { import = 'plugins.startuptime' },
  { import = 'plugins.sleuth' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.copilot' },
  -- { import = 'plugins.copilot-chat' },
  { import = 'plugins.obsidian' },
  { import = 'plugins.silicon' },
  -- { import = 'plugins.live-share' },
  { import = 'plugins.hexokinase' },
  { import = 'plugins.tmux-navigator' },
  { import = 'plugins.presence' },
  { import = 'plugins.none-ls' },
  { import = 'plugins.lualine' },
  { import = 'plugins.mini-bufremove' },
  { import = 'plugins.harpoon' },
  -- { import = 'plugins.nvim-tree' },
  { import = 'plugins.image' },
  { import = 'plugins.neo-tree' },
  { import = 'plugins.aerial' },
  { import = 'plugins.comment' },
  { import = 'plugins.lazygit' },
  { import = 'plugins.autopairs' },
  { import = 'plugins.autotag' },
  { import = 'plugins.render-markdown' },
  { import = 'plugins.which-key' },
  { import = 'plugins.notify' },
  { import = 'plugins.noice' },
  { import = 'plugins.dashboard' },
  { import = 'plugins.refactoring' },
  { import = 'plugins.neorg' },
  { import = 'plugins.telescope' },
  { import = 'plugins.lazydev' },
  { import = 'plugins.luvit-meta' },
  { import = 'plugins.lspconfig' },
  { import = 'plugins.dap' },
  { import = 'plugins.dap-ui' },
  { import = 'plugins.conform' },
  { import = 'plugins.cmp' },
  { import = 'plugins.transparent' },
  { import = 'plugins.thorn' },
  { import = 'plugins.catppuccin' },
  { import = 'plugins.todo-comments' },
  { import = 'plugins.mini' },
  { import = 'plugins.mdx' },
  { import = 'plugins.treesitter' },

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins.
  --
  --  The `lua/kickstart/plugins/` directory still ships the original Kickstart
  --  examples (debug, indent_line, lint, autopairs, neo-tree, gitsigns). Most of
  --  them have been superseded by the modular configs in `lua/plugins/`, but they
  --  are kept as reference. See `:help lazy.nvim-structuring-your-plugins` for
  --  how to add your own.
  --
  -- NOTE: The import below can automatically add your own plugins, configuration etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },

  -- Integration with Noctalia's matugen via base16.
  -- Compatible with V5's community template.
  --
  { import = 'plugins.base16' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
