--
-- https://github.com/folke/lazy.nvim
-- A modern plugin manager for Neovim
--
-- :help lazy.nvim.txt

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- lazy options
-- https://github.com/folke/lazy.nvim#%EF%B8%8F-configuration
local opts = {
  defaults = {
    lazy = false, -- should plugins be lazy-loaded? -- default: false
  },
  install = {
    colorscheme = { vim.g.colorscheme, 'habamax' }, -- try to load one of these colorschemes when starting an installation during startup
  },
  checker = {
    enabled = false, -- automatically check for plugin updates -- default: false
  },
  change_detection = {
    enabled = true, -- automatically check for config file changes and reload the ui -- default: true
    notify = false, -- get a notification when changes are found -- default: true
  },
  performance = {
    rtp = {
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- 'netrwPlugin',
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
}

require('lazy').setup('plugins', opts)
