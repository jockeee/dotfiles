--
-- https://github.com/akinsho/toggleterm.nvim
-- A neovim lua plugin to help easily manage multiple terminal windows

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { --Lazy-load on command
    'ToggleTerm',
  },
  keys = { -- Lazy-load on key mapping
    { '`', '<cmd>ToggleTerm direction=float<cr>', desc = 'Terminal' },
  },
  config = true,
}
