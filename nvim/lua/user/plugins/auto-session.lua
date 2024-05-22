--
-- https://github.com/rmagatti/auto-session
-- A small automated session manager for Neovim

return {
  'rmagatti/auto-session',
  opts = {
    log_level = 'error', -- default: 'info'
    auto_save_enabled = true, -- default: nil
    auto_restore_enabled = true, -- default: nil
    auto_session_enable_last_session = false, -- default: false - Loads the last loaded session if session for cwd does not exist
    auto_session_root_dir = vim.fn.stdpath 'data' .. '/sessions/', -- default: vim.fn.stdpath 'data' .. '/sessions/'
    auto_session_suppress_dirs = { '/', '~/', '~/Downloads' }, -- default: nil

    -- cwd_change_handling = {
    --   restore_upcoming_session = true, -- default: true
    --   pre_cwd_changed_hook = nil, -- default: nil
    --   post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
    --     require('lualine').refresh() -- refresh lualine so the new session name is displayed in the status bar
    --   end,
    -- },
  },
}
