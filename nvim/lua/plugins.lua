--
-- plugins.lua

return {
  -- visual
  { 'lewis6991/gitsigns.nvim', opts = {} }, -- adds git related signs to the gutter, as well as utilities for managing changes
  require 'user.plugins.colorscheme',
  require 'user.plugins.lualine', -- statusline
  require 'user.plugins.neo-tree', -- file explorer
  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.which-key', -- show pending keybinds

  -- editing
  'tpope/vim-sleuth', -- auto set tabstop, shiftwidth, etc for each file based on its contents
  'tpope/vim-unimpaired', -- handy bracket mappings
  require 'user.plugins.nvim-surround', -- add/change/delete surrounding delimiter pairs with ease
  require 'user.plugins.comment',
  require 'user.plugins.mini', -- collection of various small independent plugins/modules
  require 'user.plugins.github-copilot',

  -- functionality
  'nvim-lua/plenary.nvim', -- lua functions that many plugins use
  require 'user.plugins.auto-session',
  require 'user.plugins.neogit', -- interactive git interface
  require 'user.plugins.telescope', -- fuzzy finder (files, lsp, etc)
  require 'user.plugins.toggleterm',
  require 'user.plugins.treesitter', -- highlight, edit, and navigate code
  require 'user.plugins.vim-tmux-navigator', -- ctrl-hjkl\ keymaps that works with both tmux and nvim panes

  -- lsp, linting, formatting, autocompletion
  require 'user.plugins.lsp-config',
  require 'user.plugins.conform', -- formatting
  require 'user.plugins.nvim-cmp', -- autocompletion, snippets
}
