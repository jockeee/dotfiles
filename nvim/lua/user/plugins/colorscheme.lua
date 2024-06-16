--
-- colorschemes.lua
-- update global variable `vim.g.colorscheme` in `lua/user/globals.lua` with the colorscheme you want to use
--
-- :Telescope colorscheme

return {
  -- catppuccin
  -- https://github.com/catppuccin/nvim
  -- Soothing pastel theme for (Neo)vim
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin'
    -- end,
  },

  -- sonokai
  -- https://github.com/sainnhe/sonokai
  -- High contrast, dark theme for neovim
  -- {
  --   'sainnhe/sonokai',
  --   name = 'sonokai',
  --   priority = 1000,
  --   init = function()
  --     vim.g.sonokai_style = 'atlantis'
  --     vim.cmd.colorscheme 'sonokai'
  --   end,
  -- },

  -- https://github.com/Mofiqul/vscode.nvim
  -- Neovim/Vim color scheme inspired by Dark+ and Light+ theme in Visual Studio Code
  {
    'Mofiqul/vscode.nvim',
    name = 'vscode',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'vscode'
    end,
  },
}
