-- --------------------
-- WHICHKEY
-- --------------------

-- Plugins can also be configured to run lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

-- show pending keybinds
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- sets the loading event to 'VimEnter'
  opts = {},
  config = function() -- this is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      -- ['<leader>b'] = { name = 'buffer', _ = 'which_key_ignore' },
      ['<leader>c'] = { name = 'code', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = 'document', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = 'find', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = 'git', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = 'workspace', _ = 'which_key_ignore' },
    }
  end,
}
