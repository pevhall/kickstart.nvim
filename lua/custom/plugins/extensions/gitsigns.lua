--[[
  File: gitsigns.lua
  Description: Configuration of gitsigns
  See: https://github.com/lewis6991/gitsigns.nvim
]]

local gitsigns = require 'gitsigns'
gitsigns.setup {
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', --'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then
        return ']h'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[h', function()
      if vim.wo.diff then
        return '[h'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function()
      gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end)
    map('v', '<leader>hr', function()
      gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hh', gs.preview_hunk)
    map('n', '<leader>hb', function()
      gs.blame_line { full = true }
    end)
    map('n', '<leader>htb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function()
      gs.diffthis '~'
    end)
    map('n', '<leader>htd', gs.toggle_deleted)

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
}
