-- --------------------
-- TOGGLETERM
-- --------------------

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
