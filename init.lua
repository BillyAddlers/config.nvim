--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
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
require('lazy').setup({
  -- NOTE: Plugin to check startup time
  -- Good to check any overhead plugins
  'dstein64/vim-startuptime',
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: GitHub Copilot Plugin so I can gitgud.
  --
  -- adds some good ol' code generation and code completion
  {
    'github/copilot.vim',
    enabled = false,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim', -- Copilot Chat
    enabled = false,
    branch = 'canary',
    init = function()
      local copilot = require 'CopilotChat'
      local keymap = require 'which-key'
      keymap.add {
        mode = { 'n', 'v' },
        { '<leader>cc', '<cmd>CopilotChatToggle <CR>', desc = 'Copilot Chat' },
      }
    end,
    dependencies = {
      'github/copilot.vim',
      'nvim-lua/plenary.nvim', -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
    },
  },

  -- NOTE: A plugin to generate beautiful images of your code.
  --
  -- REMEMBER: The true Text Editor is Vim/Neovim!
  {
    'michaelrommel/nvim-silicon',
    lazy = true,
    cmd = 'Silicon',
    -- Setting a custom keymap for Silicon.
    init = function()
      local keymap = require 'which-key'
      local silicon = require 'nvim-silicon'
      keymap.add {
        mode = { 'v' },
        { '<leader>s', group = 'Silicon' },
        {
          '<leader>sc',
          function()
            silicon.clip()
          end,
          desc = 'Copy [S]ilicon render to [c]lipboard',
        },
        {
          '<leader>sf',
          function()
            silicon.file()
          end,
          desc = 'Save [S]ilicon render to [f]ile',
        },
        {
          '<leader>ss',
          function()
            silicon.shoot()
          end,
          desc = 'Take a [S]ilicon [s]creenshot',
        },
      }
    end,

    -- Setting up Silicon with some custom configuration.
    -- Randomized color from the custom function defined above.
    config = function()
      require('nvim-silicon').setup {
        no_line_number = true,

        -- Font used in my WezTerm.
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
  },

  -- NOTE: A Neovim-based live-share plugin for live collaboration
  -- Based on instant.nvim, forwarded using serveo.net/localhost.run
  {
    'azratul/live-share.nvim',
    dependencies = {
      'jbyuki/instant.nvim',
    },
    config = function()
      vim.g.instant_username = 'your-username'
      require('live-share').setup {
        port_internal = 9876, -- The local port to be used for the live share connection
        max_attempts = 20, -- Maximum number of attempts to read the URL from service(serveo.net or localhost.run), every 250 ms
        service_url = '/tmp/service.url',
        service = 'nokey@localhost.run', -- Service to use, options are serveo.net or localhost.run
      }
    end,
  },

  -- NOTE: A Vim-based plugin to show assigned color in hex codes
  -- Minimal config with virtual display besides hex codes.
  {
    'rrethy/vim-hexokinase',
  },

  -- NOTE: A plugin to navigate between tmux panes and vim splits.
  -- See `:help vim-tmux-navigator` for more information.
  -- This plugin allows you to use the same keybinds to navigate between tmux panes and vim splits.
  -- This is especially useful if you use tmux and vim together.
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  -- NOTE: A plugin for Discord Rich Presence in Neovim
  -- See `:help presence.nvim` for more information.
  --
  -- REMEMBER: The true Text Editor is Vim/Neovim!
  'andweeb/presence.nvim',

  -- NOTE: Null-ls is a plugin that allows you to use LSP features without an LSP server.
  -- It's a great way to get started with LSP features without needing to install a server.
  -- It also offer integration between LSP and other tools like prettier, eslint, etc.
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

  { -- Statusline bottom-side
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
          theme = 'catppuccin', -- was 'horizon' before
        },
        extensions = {
          'nvim-tree',
          'neo-tree',
        },
      }
    end,
  },

  { 'echasnovski/mini.bufremove', lazy = true },

  -- NOTE: Harpoon
  -- it just works.
  --
  -- Harpoon is a plugin that allows you to save and navigate to different files in your project.
  -- It's a great way to quickly jump between files that you're working on.
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 2,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          '<leader>a',
          function()
            require('harpoon'):list():add()
          end,
          desc = 'H[a]rpoon File',
        },
        {
          '<leader>h',
          function()
            local harpoon = require 'harpoon'
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = '[H]arpoon Quick Menu',
        },
      }

      for i = 1, 9 do
        table.insert(keys, {
          '<leader>' .. i,
          function()
            require('harpoon'):list():select(i)
          end,
          desc = 'Harpoon to File ' .. i,
        })
        table.insert(keys, {
          '<M-' .. i .. '>',
          function()
            require('harpoon'):list():select(i)
          end,
          desc = 'Harpoon to File ' .. i,
        })
      end
      return keys
    end,
  },

  -- NOTE: nvim-tree to navigate through project structure.
  -- See `:help nvim-tree` for more information
  --
  -- It give sense of having an actuall full fledged IDE
  {
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
  },

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
  {
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
  },

  -- NOTE: Neo-Tree is a plugin that allows you to navigate through your project structure.
  -- It's a great way to quickly jump between files that you're working on.
  -- We'll be using this from now on instead of Nvim-Tree, because Neo-tree supports buffer source.
  --
  -- See `:help neo-tree` for more information
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim',
    },
    cmd = 'Neotree',
    keys = {
      mode = { 'n' },
      { '<leader>e', '<cmd>Neotree toggle <CR>', desc = 'Open File [E]xplorer' },
    },
    init = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError' })
      vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn' })
      vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo' })
      vim.fn.sign_define('DiagnosticSignHint', { text = '󰌵', texthl = 'DiagnosticSignHint' })
    end,
    opts = {
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'qf', 'edgy' },
      use_image_preview = true,
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      enable_git_status = true, -- Enable git status for files
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      default_component_configs = {
        modified = {
          symbol = '[+]',
          highlight = 'NeoTreeModified',
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = 'NeoTreeFileName',
          format = function(item)
            return vim.fn.fnamemodify(item.path, ':p') -- Use absolute path
          end,
        },
        git_status = {
          symbols = {
            -- Change type
            added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = '✖', -- this can only be used in the git_status source
            renamed = '󰁕', -- this can only be used in the git_status source
            -- Status type
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '',
            conflict = '',
          },
        },
      },
      commands = {
        -- NOTE: Uncomment this if you're using image_preview.nvim for image preview.
        --
        -- image_wezterm = function(state)
        --   local node = state.tree:get_node()
        --   if node.type == 'file' then
        --     require('image_preview').PreviewImage(node.path)
        --   end
        -- end,
      },
      window = {
        position = 'float',
        popup = {
          size = {
            height = '80%', -- Floating window height (percentage or fixed)
            width = '25%', -- Floating window width (percentage or fixed)
          },
          border = 'rounded', -- Border style for floating window
          position = {
            row = 1, -- Align the floating window vertically near the top
            col = 1000, -- Align it near the left side (close to line numbers)
          },
          offset = {
            row = 0,
            col = 2, -- Slightly move it away from the very left, next to line numbers
          },
        },
        mappings = {
          -- NOTE: REFER TO THIS TWO LINES BELOW FOR IMAGE PREVIEW MAPPINGS
          -- Uncomment one of them to use image preview (or just simply use both, it's up to you)
          ['P'] = { 'toggle_preview', config = { use_float = true, use_image_nvim = true, use_image_preview = true } },
          -- ['I'] = 'image_wezterm',
          --
          -- These lines below are standard mappings for neo-tree
          -- Feel free to add more.
          ['l'] = 'focus_preview',
          ['S'] = 'open_split',
          ['s'] = 'open_vsplit',
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_hidden = true, -- only works on Windows for hidden files/directories
          hide_by_name = {
            --"node_modules"
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
          always_show_by_pattern = { -- uses glob style patterns
            --".env*",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            --".DS_Store",
            --"thumbs.db"
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
      },
      buffers = {
        window = {
          mappings = {
            ['<cr>'] = 'open_with_window_picker',
            ['l'] = 'open_with_window_picker',
            ['<2-LeftMouse>'] = 'open_with_window_picker',
          },
        },
        components = {
          {
            'name',
            highlight = 'NeoTreeFileName',
            format = function(item)
              return vim.fn.fnamemodify(item.path, ':p') -- Use absolute path
            end,
          },
        },
      },
    },
  },

  -- NOTE: Plugin to display Outline of current open buffer.
  --
  -- A robust tool second to Neo-tree for code management.
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      require('aerial').setup {
        layout = {
          width = 40,
          default_direction = 'right',
          placement = 'edge',
        },
        -- Options for opening aerial in a floating win
        float = {
          -- Controls border appearance. Passed to nvim_open_win
          border = 'rounded',

          -- Determines location of floating window
          --   cursor - Opens float on top of the cursor
          --   editor - Opens float centered in the editor
          --   win    - Opens float centered in the window
          relative = 'editor',

          -- These control the height of the floating window.
          -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a list of mixed types.
          -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
          max_height = 0.9,
          height = nil,
          min_height = { 8, 0.1 },

          override = function(conf, source_winid)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
          end,
        },
        autojump = true,
        -- Options for the floating nav windows
        nav = {
          border = 'rounded',
          max_height = 0.9,
          min_height = { 10, 0.1 },
          max_width = 0.5,
          min_width = { 0.2, 20 },
          win_opts = {
            cursorline = true,
            winblend = 10,
          },
          -- Show a preview of the code in the right column, when there are no child symbols
          preview = false,
          -- Keymaps in the nav window
          keymaps = {
            ['<CR>'] = 'actions.jump',
            ['<2-LeftMouse>'] = 'actions.jump',
            ['<C-v>'] = 'actions.jump_vsplit',
            ['<C-s>'] = 'actions.jump_split',
            ['h'] = 'actions.left',
            ['l'] = 'actions.right',
            ['<C-c>'] = 'actions.close',
          },
        },
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
      }
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>E', '<cmd>AerialToggle float<CR>', { desc = 'Toggle Aerial [E]xplorer' })
    end,
  },

  -- NOTE: Comment plugin to comment out code
  {
    'numToStr/Comment.nvim',
    event = 'BufReadPre',
    lazy = false,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- Lmao I forgot to initialize config.
      local prehook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
      require('Comment').setup {
        padding = true,
        sticky = true,
        ignore = '^$',
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
        mappings = {
          basic = true,
          extra = true,
          extended = false,
        },
        pre_hook = prehook,
        post_hook = nil,
      }
    end,
  },

  --NOTE: You can never get lazier, even if it's NeoVim!
  --  LazyGit is a plugin that allows you to use Git commands in a more visual way.
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>g', '<cmd>LazyGit<cr>', desc = '[L]azy [G]it' },
    },
  },

  -- NOTE: A plugin to help with autopairing brackets, quotes, etc.
  -- Simple but strong!
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- Adding cmp autopairs
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done {})
    end,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  -- NOTE: A plugin to help with autotagging HTML tags.
  -- It's a great way to quickly close tags when writing HTML.
  --
  -- Same developer with nvim-autopairs, so it's a great combo!
  --
  {
    'windwp/nvim-ts-autotag',
    event = 'BufRead',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = true,
          },
          ['javascript'] = {
            enable_close = true,
          },
          ['typescript'] = {
            enable_close = true,
          },
          ['jsx'] = {
            enable_close = true,
          },
          ['tsx'] = {
            enable_close = true,
          },
          ['svelte'] = {
            enable_close = true,
          },
          ['vue'] = {
            enable_close = true,
          },
        },
      }

      -- Handling LSP errors only when using `Insert` mode.
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = {
          spacing = 5,
          min = {
            severity = 'warnings',
          },
        },
        update_in_insert = true,
      })
    end,
  },

  -- NOTE: Markdown Preview Plugin
  -- This plugin allows you to preview markdown files in your browser.
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && npm install',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode and Debuggers', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Configuring nvim-notify because it kept throwing warnings
  {
    'rcarriga/nvim-notify',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    init = function()
      local notify = require 'notify'

      -- Replacing default vim.notify with nvim-notify
      vim.notify = notify
    end,
    opts = {
      background_colour = '#1e1e1e', -- Darker background color
      timeout = 5000, -- Adjust timeout for notifications
      stages = 'fade', -- Customize animation stages if needed
    },
  },

  -- NOTE: A highly experimental plugin that completely replaces the UI for `messages`, `cmdline`, and the `popupmenu`
  -- Sir Folke made something good other than which-key
  --
  -- All hail Neovim!
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      markdown = {
        renderer = 'treesitter',
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- NOTE: A plugin to show you the keymaps that are available in Neovim.
  --
  -- Greet you with something greater than yourself.
  -- All hail Neovim!
  {
    'goolord/alpha-nvim',
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local startify = require 'alpha.themes.startify'
      -- available: devicons, mini, default is mini
      -- if provider not loaded and enabled is true, it will try to use another provider
      startify.file_icons.provider = 'devicons'
      require('alpha').setup(startify.config)
    end,
  },

  -- NOTE: A plugin to help with refactoring code.
  -- This plugin allows you to easily refactor your code.
  --
  -- It's a great way to quickly make changes to your code without having to do it manually.
  -- ThePrimeagen makes something good other than Harpoon2.
  {
    'ThePrimeagen/refactoring.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup {
        -- Optional: additional configuration
      }
      vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
        require('refactoring').select_refactor()
      end, { desc = 'Advanced [R]efactoring' })
    end,
  },

  -- NOTE: A Note-taking plugins.
  -- Replacing default note-taking feature from Telescope.
  {
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
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        -- NOTE: We'll be adding our own Harpoon2 picker in the code below extensions
        -- to allow us to quickly navigate between files in our project.
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- [[ Configure Harpoon2 ]]
      -- See `:help harpoon` and `:help harpoon.setup()`
      -- NOTE: Configuring Harpoon2 integration to Telescope UI
      -- This allows us to quickly navigate between files in our project.
      local harpoon = require 'harpoon'
      local keymap = require 'which-key'
      local conf = require('telescope.config').values
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'
      local builtin = require 'telescope.builtin'

      -- Re-init harpoon configurations
      harpoon:setup {}

      -- Displaying harpoon buffers in Telescope UI
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, file in ipairs(harpoon_files.items) do
          table.insert(file_paths, file.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon Buffers',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
            -- Adding custom mappings so Harpoon buffers can be removed from Telescope UI
            attach_mappings = function(prompt_bufnr, map)
              -- Custom action to remove buffer from Harpoon
              local function remove_buffer()
                local selection = action_state.get_selected_entry()
                local selected_file = selection[1]

                -- Find the index of the selected file in Harpoon list and remove it
                for i, item in ipairs(harpoon:list().items) do
                  if item.value == selected_file then
                    harpoon:list():remove_at(i)
                    print('Removed ' .. selected_file .. ' from Harpoon')
                    break
                  end
                end

                -- Close the current Telescope UI
                -- actions.close(prompt_bufnr)

                -- Refresh the Telescope picker with the updated Harpoon list
                toggle_telescope(harpoon:list()) -- Call toggle_telescope again with updated list
              end

              -- Map custom action to key (e.g., <C-d> to delete)
              map('i', '<C-d>', remove_buffer)
              map('n', '<C-d>', remove_buffer)
              map('n', 'dd', remove_buffer)

              return true
            end,
          })
          :find()
      end

      keymap.add {
        mode = { 'n', 'v' },
        {
          '<leader>H',
          function()
            toggle_telescope(harpoon:list())
          end,
          desc = '[H]arpoon Fles',
        },
      }
      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'harpoon')
      pcall(require('telescope').load_extension 'notify')
      pcall(require('telescope').load_extension 'refactoring')
      pcall(require('telescope').load_extension 'aerial')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- [[ Custom Telescope Search ]]
      -- This is used to map for Personal Notes directory.
      -- Kinda useful if you're looking for something like Inkdrop/Notion but don't wanna use 3rd party services.
      -- Recommended to install 'iamcco/markdown-preview.nvim' as well to render Markdown notes.
      -- NOTE: This is for a personal notes directory.
      -- WARN: Note-taking activities are moved to Neorg, please refer to that plugin using search feature.
      -- More info on 'nvim-neorg/neorg' repository.
      keymap.add {
        mode = { 'n' },
        {
          '<leader>sq',
          function()
            builtin.find_files {
              cwd = '~/.notes',
            }
          end,
          desc = '[S]earch for Personal Notes, [Q]',
        },
      }

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'jay-babu/mason-nvim-dap.nvim', event = 'VeryLazy' },

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- NOTE: C/C++ LSP
        clangd = {},
        -- NOTE: GoLang LSP
        gopls = {
          analyses = {
            unusedparams = true, -- Find unused function parameters
            nilness = true, -- Check for redundant or missing nil checks
            shadow = true, -- Detect shadowed variables
          },
          staticcheck = true, -- Enable static analysis checks
        },
        -- NOTE: Rust LSP
        rust_analyzer = {},

        -- NOTE: Python LSP
        pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- NOTE: And of course, you had to use these set of LSPs.
        ts_ls = {},
        eslint = {},
        tailwindcss = {},
        html = {},
        -- Framework-specific LSP
        angularls = {},
        vue_ls = {},
        svelte = {},
        mdx_analyzer = {
          filetypes = { 'markdown.mdx', 'mdx' },
        },
        -- Support for markdown (below) and .mdx (above)
        marksman = {},
        -- KingTS on top!
        --
        -- Additional necessities for personal development
        -- NOTE: Docker stuff
        dockerls = {},
        docker_compose_language_service = {},

        -- NOTE: Arduino Language Server
        arduino_language_server = {},

        -- NOTE: Lua LSP
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- NOTE: An experimental config for DAP (Debug Adapter Protocol)
  -- I dunno why ppl wanna do cpp, just write in golang or rust lmao.
  -- But hey, it's your choice.
  --
  -- This plugin allows you to debug your code in Neovim.
  -- It's a powerful tool that can help you find and fix bugs in your code.
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      -- Below is where we declare custom adapters for our debugger.
      --
      -- Refer to https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation for various debuggers.

      -- NOTE: C/C++/Rust Adapter
      dap.adapters.codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          -- Path to codelldb (expanded from ~)
          command = vim.fn.expand '~/.local/share/nvim/mason/bin/codelldb',
          args = { '--port', '${port}' },

          -- On windows you may have to uncomment this:
          -- detached = false,
        },
      }
      -- NOTE: GoLang Delve Adapter
      dap.adapters.delve = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = { 'dap', '-l', '127.0.0.1:${port}' },
          -- add this if on windows, otherwise server won't open successfully
          -- detached = false
        },
      }

      -- Below is where we declare custom configurations for our debugger.
      -- This is where we specify the program to debug, the working directory, etc.
      -- You can have multiple configurations for different types of debugging.
      -- For example, you could have a configuration for debugging a server, and another for debugging a client.
      -- Most debugger config options are consuming avaiable adapters above.

      -- NOTE: C/C++ Configuration
      dap.configurations.cpp = {
        {
          name = 'Launch file',
          type = 'codelldb',
          request = 'launch',
          program = function()
            -- Try to detect the executable automatically or prompt the user
            local cwd = vim.fn.getcwd()
            local executable = cwd .. '/main' -- Adjust 'main' to your binary name
            if vim.fn.filereadable(executable) == 1 then
              return executable
            else
              return vim.fn.input('Path to executable: ', cwd .. '/', 'file')
            end
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      -- NOTE: GoLang Configuration
      -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
      dap.configurations.go = {
        {
          type = 'delve',
          name = 'Debug',
          request = 'launch',
          program = '${file}',
        },
        {
          type = 'delve',
          name = 'Debug test', -- configuration for debugging test files
          request = 'launch',
          mode = 'test',
          program = '${file}',
        },
        -- works with go.mod packages and sub packages
        {
          type = 'delve',
          name = 'Debug test (go.mod)',
          request = 'launch',
          mode = 'test',
          program = './${relativeFileDirname}',
        },
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    event = 'VeryLazy',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
    },
    keys = {
      {
        '<leader>cu',
        function()
          require('dapui').toggle()
        end,
        desc = '[C]ode DAP [U]I',
      },
      {
        '<leader>cb',
        function()
          require('dap').toggle_breakpoint() -- NOTE: Toggle breakpoint
        end,
        desc = '[C]ode DAP [B]reakpoints',
      },
      {
        '<leader>ce',
        function()
          require('dap').repl.open()
        end,
        desc = '[C]ode DAP R[e]pl',
      },
      {
        '<leader>cr',
        function()
          require('dap').continue()
        end,
        desc = '[C]ode DAP [R]un',
      },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },

  -- NOTE: Sometimes I forgot we have conform.
  --
  -- Just a friendly reminder that this plugin exist.
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { 'assembly' }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters = {
        ['markdown-toc'] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find '<!%-%- toc %-%->' then
                return true
              end
            end
          end,
        },
        ['markdownlint-cli2'] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == 'markdownlint'
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gofumpt', 'goimports', 'gofmt' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
        ['markdown'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
        ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
          {
            'js-everts/cmp-tailwind-colors',
            config = function()
              require('cmp-tailwind-colors').setup {
                enable_alpha = true, -- requires pumblend > 0.

                format = function(itemColor)
                  return {
                    fg = itemColor,
                    bg = itemColor, -- or nil if you dont want a background color
                    text = '  ', -- or use an icon
                  }
                end,
              }
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      local kind_icons = {
        Text = '',
        Method = '󰆧',
        Function = '󰊕',
        Constructor = '',
        Field = '󰇽',
        Variable = '󰂡',
        Class = '󰠱',
        Interface = '',
        Module = '',
        Property = '󰜢',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰏿',
        Struct = '',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰅲',
      }

      cmp.setup {
        formatting = {
          fields = { 'kind', 'abbr', 'menu' }, -- order of columns,
          format = function(entry, item)
            item.menu = item.kind
            item = require('cmp-tailwind-colors').format(entry, item)
            if kind_icons[item.kind] then
              item.kind = kind_icons[item.kind] .. ' '
            end
            return item
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    -- 'folke/tokyonight.nvim',
    'catppuccin/nvim',
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
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Commenting plugin that respects the current filetype
      -- and uses treesitter to determine the correct commentstring
      require('mini.comment').setup {
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }

      local minicon = require 'mini.icons'
      minicon.setup()
      minicon.mock_nvim_web_devicons()

      local statusline = require 'mini.statusline'

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Adding mdx support to nvim-treesitter
    'davidmh/mdx.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'master', -- Add this line to use the legacy version
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'typescript',
        'tsx',
        'go',
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'regex',
        'norg',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
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
