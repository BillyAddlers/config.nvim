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

    -- WORKAROUNDS for folke/snacks.nvim#2918 (fix is still unmerged). Drop all
    -- of these once it lands in a release.

    local placement = require('snacks.image.placement')
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
    local doc = require('snacks.image.doc')
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
  end,
}
