-- NOTE: A plugin to help with autotagging HTML tags.
-- It's a great way to quickly close tags when writing HTML.
--
-- Same developer with nvim-autopairs, so it's a great combo!
--
return {
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

    -- Handle LSP diagnostics display.
    vim.diagnostic.config {
      underline = true,
      virtual_text = {
        spacing = 5,
        severity = { min = vim.diagnostic.severity.WARN },
      },
      update_in_insert = true,
    }
  end,
}
