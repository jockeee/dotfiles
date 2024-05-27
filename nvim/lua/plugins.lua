--
-- plugins.lua

return {
  --
  -- --------------------
  -- base
  -- --------------------

  'nvim-lua/plenary.nvim', -- lua functions that many plugins use

  --
  -- --------------------
  -- ui/ux
  -- --------------------

  require 'user.plugins.colorscheme', -- colorscheme
  'tpope/vim-sleuth', -- detect tabstop and shiftwidth automatically

  require 'user.plugins.todo-comments', -- highlight todo, notes, etc in comments
  require 'user.plugins.which-key', -- show pending keybinds

  require 'user.plugins.treesitter', -- highlight, edit, and navigate code
  require 'user.plugins.telescope', -- fuzzy finder (files, lsp, etc)

  require 'user.plugins.bufferline', -- tabs for open buffers
  require 'user.plugins.lualine', -- statusline
  require 'user.plugins.neo-tree', -- file explorer

  require 'user.plugins.cellular-automaton', -- a useless plugin ... L-fml

  --
  -- --------------------
  -- functionality
  -- --------------------

  require 'user.plugins.vim-tmux-navigator', -- ctrl-hjkl\ keymaps that works with both tmux and nvim panes
  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines
  require 'user.plugins.mini', -- collection of various small independent plugins/modules
  require 'user.plugins.aerial', -- code outline window

  require 'user.plugins.toggleterm',
  require 'user.plugins.github-copilot',

  -- require 'user.plugins.vim-visual-multi',
  -- require 'user.plugins.auto-session',
  -- require 'user.plugins.nvim-autopairs',
  -- require 'user.plugins.multicursors',

  --
  -- --------------------
  -- git
  -- --------------------

  { 'lewis6991/gitsigns.nvim', opts = {} }, -- adds git related signs to the gutter, as well as utilities for managing changes
  require 'user.plugins.neogit', -- interactive git interface

  --
  -- --------------------
  -- lsp
  -- --------------------

  require 'user.plugins.lsp-config',
  require 'user.plugins.conform', -- code formatting
  require 'user.plugins.nvim-cmp', -- code completion, snippets

  --
  -- --------------------
  -- extras
  -- --------------------

  -- require 'user.plugins.debug',

  --
  -- --------------------
  -- custom
  -- --------------------

  -- import can automatically add plugins, configuration, etc
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}
