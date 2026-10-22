-- NOTE: snacks.nvim is a collection of small QoL plugins. Only the modules that
-- do not duplicate something already in this config are enabled here.
--
-- Deliberately NOT enabled (they would override or compete with existing plugins):
--   notifier -> rcarriga/nvim-notify + folke/noice.nvim
--   input    -> folke/noice.nvim
--   picker   -> nvim-telescope/telescope.nvim
--   explorer -> nvim-neo-tree/neo-tree.nvim
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    image = {
      enabled = true,
      doc = {
        enabled = true, -- inline images in supported documents (markdown, html, norg, ...)
        inline = true, -- render inline when the terminal supports unicode placeholders
        float = true, -- fall back to a floating window when inline is unsupported
        max_width = 80,
        max_height = 40,
      },
    },
    indent = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    require('snacks').setup(opts)

    -- WORKAROUNDS for folke/snacks.nvim. Drop each once the corresponding
    -- upstream fix lands in a release.

    local placement = require 'snacks.image.placement'
    local ns = placement.ns
    local uv = vim.uv or vim.loop

    -- 1. An image file renders the first time, then comes back blank after its
    -- buffer leaves the window and returns. snacks latches the placement hidden
    -- on BufWinLeave and never un-hides it, because only `snacks.image.inline`
    -- (doc images) ever calls `show()`.
    local update = placement.update
    placement.update = function(self, ...)
      if self.hidden and not self.opts.inline and #self:wins() > 0 then
        self.hidden = false
      end
      return update(self, ...)
    end

    -- 2. Closing an image buffer while the image is still being converted
    -- leaks the progress-spinner timer, so reopening the file shows a spinner
    -- forever. Stop the timer once the placement is closed and remove the
    -- spinner extmark instead of leaving it behind.
    placement.progress = function(self)
      if self.opts.inline or self:ready() then
        return
      end
      vim.bo[self.buf].modifiable = true
      vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, {})
      vim.bo[self.buf].modifiable = false
      local timer = assert(uv.new_timer())
      local eid ---@type number?
      timer:start(
        0,
        80,
        vim.schedule_wrap(function()
          local valid = vim.api.nvim_buf_is_valid(self.buf)
          if self.closed or self:ready() or self.img:failed() or not valid then
            timer:stop()
            if not timer:is_closing() then
              timer:close()
            end
            if eid and valid then
              vim.api.nvim_buf_del_extmark(self.buf, ns, eid)
            end
            return
          end
          vim.api.nvim_buf_clear_namespace(self.buf, ns, 0, -1)
          eid = vim.api.nvim_buf_set_extmark(self.buf, ns, 0, 0, {
            virt_text = {
              { Snacks.util.spinner(), 'SnacksImageSpinner' },
              { ' ' },
              { self.img._convert:current().name .. ' loading …', 'SnacksImageLoading' },
            },
          })
        end)
      )
    end

    -- 3. An HTML image block in markdown is rendered twice. mdx.nvim injects
    -- every `html_block` as typescriptreact on top of the base `html`
    -- injection, so the same `<img>` node is matched by the images query in
    -- both trees. Dedup by source + start position: the two trees can report a
    -- different end position for the same node, but never a different start.
    local doc = require 'snacks.image.doc'
    local find = doc.find
    doc.find = function(buf, cb, find_opts)
      return find(buf, function(matches)
        local seen, deduped = {}, {}
        for _, match in ipairs(matches) do
          local key = (match.src or match.content_id or '') .. '|' .. table.concat(match.pos or match.range or {}, ',')
          if not seen[key] then
            seen[key] = true
            deduped[#deduped + 1] = match
          end
        end
        cb(deduped)
      end, find_opts)
    end

    -- 4. Images are cached by path alone: in memory (`images` keyed by file)
    -- and on disk (`sha256(path)` conversion output, skipped when it already
    -- exists). Replacing an image therefore keeps the stale pixels until
    -- Neovim restarts. Give every content version its own path so all cache
    -- layers miss. See folke/snacks.nvim#1394.
    local cache = Snacks.image.config.cache
    local refs = cache .. '/refs'
    vim.fn.mkdir(refs, 'p')

    local aliases = {} ---@type table<string, string>

    ---@param src string
    ---@return string
    local function versioned(src)
      -- keep `#page=N` out of the filesystem lookup
      local path, page = src:match '^(.-)#page=(%d+)$'
      path = path or src
      page = page and ('#page=' .. page) or ''

      -- never alias an alias
      if path:find(refs, 1, true) == 1 then
        return src
      end

      local stat = uv.fs_stat(path)
      if not stat or not stat.mtime then
        return src
      end

      local key = ('%s-%d-%d-%d-%d-%d'):format(
        vim.fn.sha256(path):sub(1, 12),
        stat.mtime.sec,
        stat.mtime.nsec or 0,
        stat.ctime and stat.ctime.sec or 0,
        stat.ctime and stat.ctime.nsec or 0,
        stat.size
      )
      local alias = aliases[key]
      if alias and uv.fs_stat(alias) then
        return alias .. page
      end

      local ext = vim.fn.fnamemodify(path, ':e')
      alias = refs .. '/' .. key .. (ext ~= '' and ('.' .. ext) or '')
      if not uv.fs_stat(alias) and not uv.fs_symlink(path, alias) then
        return src
      end
      aliases[key] = alias
      return alias .. page
    end

    local doc_images = require 'snacks.image.doc'
    local find_images = doc_images.find
    doc_images.find = function(buf, cb, find_opts)
      return find_images(buf, function(matches)
        for _, match in ipairs(matches) do
          if match.src then
            match.src = versioned(match.src)
          end
        end
        cb(matches)
      end, find_opts)
    end

    -- Track inline instances per buffer so a refocus can re-run the doc
    -- image lookup.
    local inline_by_buf = {} ---@type table<number, snacks.image.inline>
    local inline = require 'snacks.image.inline'
    local new_inline = inline.new
    inline.new = function(buf)
      local self = new_inline(buf)
      inline_by_buf[buf] = self
      return self
    end

    -- 4b. Image buffers opened directly (`:edit`, neo-tree, picker previews)
    -- go through `buf._attach` instead of `doc.find`, so version those sources
    -- too. `supports()` is checked first: the fallback viewer renders the path
    -- as text and has to keep showing the real file name.
    local image_src = {} ---@type table<number, string>
    local image_buf = require 'snacks.image.buf'
    local buf_attach = image_buf._attach
    image_buf._attach = function(buf, opts)
      opts = opts or {}
      local src = opts.src or vim.api.nvim_buf_get_name(buf)
      if src ~= '' and Snacks.image.supports(src) then
        opts.src = versioned(src)
        image_src[buf] = opts.src
      end
      return buf_attach(buf, opts)
    end

    ---@param buf number
    local function refresh_image_buf(buf)
      local current = image_src[buf]
      if not current or not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].filetype ~= 'image' then
        return
      end
      local src = vim.api.nvim_buf_get_name(buf)
      if src ~= '' and versioned(src) ~= current then
        image_buf.attach(buf)
      end
    end

    local group = vim.api.nvim_create_augroup('snacks.image.focus', { clear = true })
    -- A file replaced by another program while Neovim was unfocused (or while
    -- another buffer was active) never triggers a buffer event, so re-check
    -- both kind of viewers when focus or buffer changes.
    vim.api.nvim_create_autocmd('FocusGained', {
      group = group,
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local inst = inline_by_buf[buf]
        if inst then
          inst:update()
        end
        refresh_image_buf(buf)
      end,
    })
    vim.api.nvim_create_autocmd('BufEnter', {
      group = group,
      callback = function()
        refresh_image_buf(vim.api.nvim_get_current_buf())
      end,
    })
    vim.api.nvim_create_autocmd({ 'BufWipeout', 'BufDelete' }, {
      group = group,
      callback = function(ev)
        image_src[ev.buf] = nil
        inline_by_buf[ev.buf] = nil
      end,
    })

    -- Versioned aliases and their conversions accumulate over time; drop
    -- cache files that have not been touched in a month.
    local cutoff = os.time() - 30 * 24 * 60 * 60
    for _, dir in ipairs { cache, refs } do
      local handle = uv.fs_scandir(dir)
      while handle do
        local name, kind = uv.fs_scandir_next(handle)
        if not name then
          break
        end
        if kind == 'file' or kind == 'link' then
          local file = dir .. '/' .. name
          local stat = uv.fs_lstat(file)
          if stat and stat.mtime and stat.mtime.sec < cutoff then
            pcall(vim.fs.rm, file)
          end
        end
      end
    end
  end,
}
