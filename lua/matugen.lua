local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Background tones
    base00 = '#14140f', -- Default Background
    base01 = '#20201a', -- Lighter Background (status bars)
    base02 = '#2b2a24', -- Selection Background
    base03 = '#949181', -- Comments, Invisibles
    -- Foreground tones
    base04 = '#cac7b6', -- Dark Foreground (status bars)
    base05 = '#e6e2d9', -- Default Foreground
    base06 = '#e6e2d9', -- Light Foreground
    base07 = '#e6e2d9', -- Lightest Foreground
    -- Accent colors
    base08 = '#ffb4ab', -- Variables, XML Tags, Errors
    base09 = '#a5d0bb', -- Integers, Constants
    base0A = '#cbc8a4', -- Classes, Search Background
    base0B = '#cfcb55', -- Strings, Diff Inserted
    base0C = '#a5d0bb', -- Regex, Escape Chars
    base0D = '#cfcb55', -- Functions, Methods
    base0E = '#cbc8a4', -- Keywords, Storage
    base0F = '#93000a', -- Deprecated, Embedded Tags
  }
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
