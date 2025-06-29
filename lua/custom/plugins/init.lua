-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- oil
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require 'custom/plugins/extensions/oil'
    end,
  },
  { -- diffview {{{
    'sindrets/diffview.nvim',
    --    lazy = true,
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require 'custom/plugins/extensions/diffview'
    end,
  }, --}}}
  { -- {{{ simple_highlighting
    'pevhall/simple_highlighting',
    config = function()
      vim.api.nvim_exec2(
        [[
        nmap <Leader>m <Plug>HighlightWordUnderCursor
        vmap <Leader>m <Plug>HighlightWordUnderCursor
        ]],
        {}
      )
    end,
  }, -- }}}
}
