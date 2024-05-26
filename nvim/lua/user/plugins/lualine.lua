-- --------------------
-- LUALINE
-- --------------------

-- TODO: you like chris@machines lualine, check his tutorial out.

-- statusline
return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- for pretty icons, but requires a nerd font
  opts = {
    options = {
      theme = vim.g.colorscheme_lualine,
      icons_enabled = vim.g.have_nerd_font,
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { '' }, -- default: 'mode'
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  },
}
