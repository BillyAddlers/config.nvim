local M = {}

function M.setup()
  require('base16-colorscheme').setup {
    -- Background tones
    base00 = '#081512', -- Default Background
    base01 = '#0f251f', -- Lighter Background (status bars)
    base02 = '#15342b', -- Selection Background
    base03 = '#1e6d5a', -- Comments, Invisibles
    -- Foreground tones
    base04 = '#99a8a4', -- Dark Foreground (status bars)
    base05 = '#a6b5b1', -- Default Foreground
    base06 = '#a6b5b1', -- Light Foreground
    base07 = '#a6b5b1', -- Lightest Foreground
    -- Accent colors
    base08 = '#933636', -- Variables, XML Tags, Errors
    base09 = '#26a589', -- Integers, Constants
    base0A = '#167a63', -- Classes, Search Background
    base0B = '#1e9177', -- Strings, Diff Inserted
    base0C = '#96e9d6', -- Regex, Escape Chars
    base0D = '#95e9d6', -- Functions, Methods
    base0E = '#93ecd7', -- Keywords, Storage
    base0F = '#3e0f0f', -- Deprecated, Embedded Tags
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
