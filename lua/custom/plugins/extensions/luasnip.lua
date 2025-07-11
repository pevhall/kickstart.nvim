require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/snippets' }

local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

local ret_filename = function(a)
  return 'name' -- vim.fn.expand('%')
end

ls.setup {
  snip_env = {
    s = function(...)
      local snip = ls.s(...)
      -- we can't just access the global `ls_file_snippets`, since it will be
      -- resolved in the environment of the scope in which it was defined.
      table.insert(getfenv(2).ls_file_snippets, snip)
    end,
    parse = function(...)
      local snip = ls.parser.parse_snippet(...)
      table.insert(getfenv(2).ls_file_snippets, snip)
    end,
    -- remaining definitions.
    ...,
  },
  ...,
}
require('luasnip.loaders.from_snipmate').lazy_load()

--vim.keymap.set({ 'i', 's' }, '<Tab>', function()
--  ls.jump(1)
--end, { silent = true })
--vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
--  ls.jump(-1)
--end, { silent = true })
