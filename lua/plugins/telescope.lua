-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin
return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  version = '*',
  -- branch = '0.1.x',
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

    vim.keymap.set({ 'n', 'v' }, '<leader>H', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon Files' })
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'harpoon')
    pcall(require('telescope').load_extension 'notify')
    -- Disabled for now
    -- pcall(require('telescope').load_extension 'refactoring')
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
    -- Deprecated in favor of Obsidian with [obsidian-nvim/obsidian.nvim](https://github.com/obsidian-nvim/obsidian.nvim)
    --
    --
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
}
