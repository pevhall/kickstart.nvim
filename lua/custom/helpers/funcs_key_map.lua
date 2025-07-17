-- Alias for function, that set new keybindings
local map = vim.api.nvim_set_keymap

-- Normal mode keybinding setter
function nm(key, command, opts)
  if opts == nil then
    opts = {}
  end
  opts['noremap'] = true
  map('n', key, command, opts)
end

-- Input mode keybinding setter
function im(key, command, opts)
  if opts == nil then
    opts = {}
  end
  opts['noremap'] = true
  map('i', key, command, opts)
end

-- Visual mode keybinding setter
function vm(key, command, opts)
  if opts == nil then
    opts = {}
  end
  opts['noremap'] = true
  map('v', key, command, opts)
end

-- Terminal mode keybinding setter
function tm(key, command, opts)
  if opts == nil then
    opts = {}
  end
  opts['noremap'] = true
  map('t', key, command, opts)
end
