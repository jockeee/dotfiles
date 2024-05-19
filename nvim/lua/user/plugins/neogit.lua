-- --------------------
--  NEOGIT
-- --------------------

-- interactive git interface
return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration

    -- Only one of these is needed, not both.
    'nvim-telescope/telescope.nvim', -- optional
    -- "ibhagwan/fzf-lua",            -- optional
  },
  cmd = { -- Lazy-load on command
    'Neogit',
  },
  config = true,
}
