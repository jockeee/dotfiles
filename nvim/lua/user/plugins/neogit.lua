-- --------------------
--  NEOGIT
-- --------------------

-- interactive git interface
return {
  'NeogitOrg/neogit',
  tag = 'v0.0.1', -- use tag v0.0.1 if neovim version is < 0.10
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    -- "ibhagwan/fzf-lua",            -- optional
  },
  config = true,
}
