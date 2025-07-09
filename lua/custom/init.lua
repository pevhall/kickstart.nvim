require 'custom/helpers/funcs_key_map'

--" use hybride/relative line numbers {{{ <https://jeffkreeftmeijer.com/vim-number/>
vim.api.nvim_command 'set number relativenumber'
vim.api.nvim_create_autocmd({ 'WinEnter', 'FocusGained', 'InsertLeave' }, {
  callback = function()
    if vim.bo.buftype ~= 'terminal' then
      vim.o.relativenumber = false
    end
  end,
})
vim.api.nvim_create_autocmd({ 'WinLeave', 'FocusLost', 'InsertEnter' }, {
  command = 'set norelativenumber',
})
--
--" Quickly select the text that was just pasted.
--
nm('gp', '`[v`]')

--"<https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump>
nm('#', ':let @/ = "\\\\<<C-r><C-w>\\\\>"<cr>:set hlsearch<cr>')
--To search for visually selected text <https://vim.fandom.com/wiki/Search_for_visually_selected_text>
-- fix: vm('//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>')
--replace all (and prevent jump)
nm('<Leader>s', 'm`:%s/<C-r>//<C-r><C-w>/g<cr>``')
--"write the command to replace all but leave open for changes (useful to keep history etc)
nm('<Leader><a-s>', ':%s/<C-r>//<C-r><C-w>/g')
--find whole words
nm('<leader>/', '/\\<\\><left><left>')
--
--" swap word under cursor with word at mark x
nm('gx', 'm``xyiw``viwp`xviwp``')
-- first, delete some text. Then, use visual mode to select some other text, and press Ctrl-S. The two pieces of text should then be swapped.
vm('<leader>gx', '<Esc>`.``gvP``P')

-- quicklist navigation
nm(']q', ':cnext<CR>')
nm('[q', ':cprevious<CR>')
-- locationlist navigation
nm(']l', ':lnext<CR>')
nm('[l', ':lprevious<CR>')
-- rebind c-y and c-e so we do not loose the functionaliy when they get remaped in other plugins
im('<a-y>', '<c-y>')
im('<a-e>', '<c-e>')
--
-- copy the current file path: {{{
--copy abs file path
nm('<leader>%', ':let @+=expand("%:p")<CR>')
--"copy file name
nm('<leader>%t', ':let @+=expand("%:t")<CR>')
--"copy directory
nm('<leader>%h', ':let @+=expand("%:p:h")<CR>')
--"copy abs file path and line number
nm('<leader>%:', ':let @+ = expand("%:p") . ":" . line(".")<CR>')
-- }}}

-- regular copy past {{{
--vm('<c-x>', '"+x')
--vm('<c-c>', '"+y')
--vm('<c-v>', '"+P')
--nm('<c-v>', '"+P')
--im('<c-v>', '<ESC>"+pa')
--im('<c-v>', '<c-r>+')

-- cmap('<c-v>'<c-v>, '<c-r>+')
-- use <C-E> for block select instead
nm('<c-e>', '<c-v>')

--To simulate |i_CTRL-R| in terminal-mode:
tm('<expr> <C-R>', "<C-\\><C-N>\"'.nr2char(getchar()).'pi'")
--}}}
--
-- to navigate windows and tabs from any mode: {{{
tm('<A-p>', '<C-\\><C-N>gT')
tm('<A-n>', '<C-\\><C-N>gt')
im('<A-p>', '<C-\\><C-N>gT')
im('<A-n>', '<C-\\><C-N>gt')
nm('<A-p>', 'gT')
nm('<A-n>', 'gt')

tm('<A-h>', '<C-\\><C-N><C-w>h')
tm('<A-j>', '<C-\\><C-N><C-w>j')
tm('<A-k>', '<C-\\><C-N><C-w>k')
tm('<A-l>', '<C-\\><C-N><C-w>l')
im('<A-h>', '<C-\\><C-N><C-w>h')
im('<A-j>', '<C-\\><C-N><C-w>j')
im('<A-k>', '<C-\\><C-N><C-w>k')
im('<A-l>', '<C-\\><C-N><C-w>l')
nm('<A-h>', '<C-w>h')
nm('<A-j>', '<C-w>j')
nm('<A-k>', '<C-w>k')
nm('<A-l>', '<C-w>l')
-- }}}

vim.keymap.set('n', '<leader>Xb', 'yy2o<ESC>kpV:!/bin/bash<CR>')
vim.keymap.set('v', '<leader>Xb', "y'<P'<O<ESC>'>o<ESC>:<C-u>'<,'>!/bin/bash<CR>")

vim.api.nvim_exec2(
  [[
function! WritePreserveDateLinux()
    let mtime = system("stat -c %.Y ".shellescape(expand('%:p')))
    write
    call system("touch --date='@".mtime."' ".shellescape(expand('%:p')))
    edit
endfunction
]],
  {}
)
