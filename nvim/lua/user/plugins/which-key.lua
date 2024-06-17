--
-- https://github.com/folke/which-key.nvim
-- WhichKey displays a popup with possible keybindings of the command you started typing.

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {},
  config = function()
    require('which-key').setup()
    require('which-key').register {
      -- ['<leader>b'] = { name = 'buffer', _ = 'which_key_ignore' },
      ['<leader>c'] = { name = 'code', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = 'document', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = 'find', _ = 'which_key_ignore' },
      -- ['<leader>g'] = { name = 'git', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = 'workspace', _ = 'which_key_ignore' },
    }
  end,
}
