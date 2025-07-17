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
nm('gp', '`[v`]', { desc = 'select the text previousely pasted' })

--"<https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump>
nm('#', ':let @/ = "\\\\<<C-r><C-w>\\\\>"<cr>:set hlsearch<cr>', { desc = 'search/highlight word under cursor do not jump' })
--To search for visually selected text <https://vim.fandom.com/wiki/Search_for_visually_selected_text>
-- fix: vm('//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>')
nm('<Leader>S', 'm`:%s/<C-r>//<C-r><C-w>/g<cr>``', { desc = 'replace search with cursor word' })
--"write the command to replace all but leave open for changes (useful to keep history etc)
nm('<Leader><a-s>', ':%s/<C-r>//<C-r><C-w>/g', { desc = 'write command to repaced search with cursor word' })
--find whole words
nm('<leader>/', '/\\<\\><left><left>', { desc = 'quickly serach for a whole word' })
--
--" swap word under cursor with word at mark x
nm('gx', 'm``xyiw``viwp`xviwp``', { desc = 'swap word under cursor with word at mark x' })
-- first, delete some text. Then, use visual mode to select some other text, and press Ctrl-S. The two pieces of text should then be swapped.
vm('<leader>gx', '<Esc>`.``gvP``P', { desc = 'delete some text, select some text, run this and the text will be switched' })

-- quicklist navigation
nm(']q', ':cnext<CR>', { desc = 'quicklist next' })
nm('[q', ':cprevious<CR>', { desc = 'quick list previouse' })
-- locationlist navigation
nm(']l', ':lnext<CR>', { desc = 'locationlist next' })
nm('[l', ':lprevious<CR>', { desc = 'locationlist previouse' })
-- rebind c-y and c-e so we do not loose the functionaliy when they get remaped in other plugins
im('<a-y>', '<c-y>', { desc = 'insert character above cursor' })
im('<a-e>', '<c-e>', { desc = 'insert character below cursor' })
--
-- copy the current file path: {{{
--copy abs file path
nm('<leader>%', ':let @+=expand("%:p")<CR>', { desc = 'copy file path' })
--"copy file name
nm('<leader>%t', ':let @+=expand("%:t")<CR>', { desc = 'copy file name' })
--"copy directory
nm('<leader>%h', ':let @+=expand("%:p:h")<CR>', { desc = 'copy file directory' })
--"copy abs file path and line number
nm('<leader>%:', ':let @+ = expand("%:p") . ":" . line(".")<CR>', { desc = 'copy <file path>:<line number>' })
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
--nm('<c-e>', '<c-v>')

--To simulate |i_CTRL-R| in terminal-mode:
tm('<expr> <C-R>', "<C-\\><C-N>\"'.nr2char(getchar()).'pi'", { desc = 'simulator <C-R> in termal' })
--}}}
--
-- to navigate windows and tabs from any mode: {{{
tm('<A-p>', '<C-\\><C-N>gT', { desc = 'Move tab perviouse' })
tm('<A-n>', '<C-\\><C-N>gt', { desc = 'Move tab next' })
im('<A-p>', '<C-\\><C-N>gT', { desc = 'Move tab perviouse' })
im('<A-n>', '<C-\\><C-N>gt', { desc = 'Move tab next' })
nm('<A-p>', 'gT', { desc = 'Move tab previouse' })
nm('<A-n>', 'gt', { desc = 'Move tab next' })

tm('<A-h>', '<C-\\><C-N><C-w>h', { desc = 'Move window to the left' })
tm('<A-j>', '<C-\\><C-N><C-w>j', { desc = 'Move window to the down' })
tm('<A-k>', '<C-\\><C-N><C-w>k', { desc = 'Move window to the up' })
tm('<A-l>', '<C-\\><C-N><C-w>l', { desc = 'Move window to the right' })
im('<A-h>', '<C-\\><C-N><C-w>h', { desc = 'Move window to the left' })
im('<A-j>', '<C-\\><C-N><C-w>j', { desc = 'Move window to the down' })
im('<A-k>', '<C-\\><C-N><C-w>k', { desc = 'Move window to the up' })
im('<A-l>', '<C-\\><C-N><C-w>l', { desc = 'Move window to the right' })
nm('<A-h>', '<C-w>h', { desc = 'Move window to the left' })
nm('<A-j>', '<C-w>j', { desc = 'Move window to the down' })
nm('<A-k>', '<C-w>k', { desc = 'Move window to the up' })
nm('<A-l>', '<C-w>l', { desc = 'Move window to the right' })
-- }}}

vim.keymap.set('n', '<leader>Xb', 'yy2o<ESC>kpV:!$SHELL<CR>', { desc = 'Run currently line through $SHELL paset results below' })
vim.keymap.set('v', '<leader>Xb', "y'<P'<O<ESC>'>o<ESC>:<C-u>'<,'>!$SHELL<CR>", { desc = 'Run currently selection through $SHELL paset results below' })

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
