--
-- init.lua

-- --------------------
-- globals
-- --------------------

-- set <space> as the leader key
-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set to true if you have a nerd font installed
vim.g.have_nerd_font = true

-- colorscheme
vim.g.colorscheme = 'catppuccin'
vim.g.colorscheme_lualine = 'catppuccin'

-- --------------------
-- user
-- --------------------

require 'user.filetypes'
require 'user.options'
require 'user.lazy'
require 'user.autocmds'
require 'user.keymaps'
