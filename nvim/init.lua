-- --------------------
-- INIT.LUA
-- --------------------

-- https://templ.guide/commands-and-tools/ide-support/#neovim--050
vim.filetype.add { extension = { templ = 'templ' } }

-- --------------------
-- globals
-- --------------------

-- set <space> as the leader key
-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- set to true if you have a nerd font installed
vim.g.have_nerd_font = true

vim.g.colorscheme = 'catppuccin'

-- --------------------
-- user
-- --------------------

require 'user.options'
require 'user.lazy'
require 'user.autocmds'
require 'user.keymaps'
