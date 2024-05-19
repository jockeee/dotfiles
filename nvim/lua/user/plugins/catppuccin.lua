-- --------------------
-- CATPPUCCIN
-- --------------------

-- use `:Telescope colorscheme` to see what colorschemes are installed
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
