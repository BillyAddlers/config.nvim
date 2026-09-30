return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  -- We use the `main` branch for better compatibility with 0.12 Neovim.
  branch = 'main',
  build = ':TSUpdate',
  config = function()
    -- Parsers are installed on first run. `norg` is not listed here because
    -- nvim-treesitter dropped it; neorg provides the parser and its queries.
    local parsers = {
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
    }
    local nvim_treesitter = require 'nvim-treesitter'

    local function has_parser(language)
      if vim.tbl_contains(nvim_treesitter.get_installed 'parsers', language) then
        return true
      end
      -- A parser only needs to be loadable to highlight, so also count the ones
      -- nvim-treesitter does not track, such as parsers kept in the plugin's own
      -- `parser` directory or shipped by another plugin.
      return #vim.api.nvim_get_runtime_file('parser/' .. language .. '.*', false) > 0
    end

    -- Building a parser shells out to the tree-sitter CLI, so parsers can only
    -- be installed when it is available. Already installed parsers always work.
    local can_install = vim.fn.executable 'tree-sitter' == 1

    local function install(langs)
      if not can_install then
        vim.notify(('nvim-treesitter: cannot install %s, the tree-sitter CLI was not found'):format(table.concat(langs, ', ')), vim.log.levels.WARN)
        return
      end
      nvim_treesitter.install(langs)
    end

    local missing = vim.tbl_filter(function(language)
      return not has_parser(language)
    end, parsers)
    if #missing > 0 then
      install(missing)
    end

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      if not vim.treesitter.language.add(language) then
        return
      end
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end

      -- Ruby's highlighting and indentation rely on Vim's regex syntax system,
      -- so keep treesitter out of it and turn Vim's syntax highlighting on.
      if language == 'ruby' then
        vim.bo[buf].syntax = 'ON'
        return
      end

      vim.treesitter.start(buf, language)

      -- Enable treesitter indentation when the language ships an `indents`
      -- query, otherwise leave the indentation the filetype set up in place.
      if vim.treesitter.query.get(language, 'indents') then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    local available_parsers = nvim_treesitter.get_available()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        if has_parser(language) then
          treesitter_try_attach(buf, language)
        elseif can_install and vim.tbl_contains(available_parsers, language) then
          -- Auto-install the parser, then attach once the build has finished.
          nvim_treesitter.install(language):await(function()
            treesitter_try_attach(buf, language)
          end)
        else
          -- Try to enable treesitter features in case the parser exists but is
          -- not available from nvim-treesitter, for example when another plugin
          -- ships it.
          treesitter_try_attach(buf, language)
        end
      end,
    })
  end,
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
