--
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- Neovim plugin to manage the file system and other tree like structures

return {
  'nvim-neo-tree/neo-tree.nvim',
  Lazy = true,
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- for pretty icons, but requires a nerd font
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = 'Neotree',
  keys = {
    { '\\', '<cmd>Neotree reveal<cr>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      filtered_items = {
        always_show = { -- remains visible even if other settings would normally hide it
          '.gitignore',
        },
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
