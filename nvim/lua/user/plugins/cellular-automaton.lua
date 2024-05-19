return {
  'eandrju/cellular-automaton.nvim',
  cmd = { --Lazy-load on command
    'CellularAutomaton',
  },
  keys = { -- Lazy-load on key mapping
    { '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>' },
  },
}
