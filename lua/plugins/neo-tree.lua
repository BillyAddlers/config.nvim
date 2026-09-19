-- NOTE: Neo-Tree is a plugin that allows you to navigate through your project structure.
-- It's a great way to quickly jump between files that you're working on.
-- We'll be using this from now on instead of Nvim-Tree, because Neo-tree supports buffer source.
--
-- See `:help neo-tree` for more information
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle <CR>', desc = 'Open File [E]xplorer', mode = 'n' },
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
      -- NOTE: In-tree image preview was removed together with `image.nvim`.
      -- snacks.nvim's image module does not integrate with Neo-tree; open the
      -- image file directly (or use `Snacks.image.hover()`) to preview it.
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
        -- NOTE: `P` toggles Neo-tree's (text) preview. The old `use_image_nvim`
        -- / `use_image_preview` flags are gone along with image.nvim.
        ['P'] = { 'toggle_preview', config = { use_float = true } },
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
}
