-- --------------------
-- NEOTREE
-- --------------------

-- file explorer
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- for pretty icons, but requires a nerd font
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    filesystem = {
      filtered_items = {
        always_show = { -- remains visible even if other settings would normally hide it
          '.gitignore',
        },
      },
    },
  },
}
