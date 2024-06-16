--
--  https://github.com/NeogitOrg/neogit
--  An interactive and powerful Git interface for Neovim, inspired by Magit

return {
  'NeogitOrg/neogit',
  tag = 'v0.0.1', -- use tag v0.0.1 if neovim version is < 0.10
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    -- "ibhagwan/fzf-lua",           -- optional
  },
  cmd = 'Neogit',
  keys = { { 'n', '<leader>g', '<cmd>Neogit<cr>', { desc = 'Neogit' } } },
  config = true,
}
