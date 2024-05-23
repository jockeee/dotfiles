--
-- https://github.com/github/copilot.vim
-- Neovim plugin for GitHub Copilot

-- :help copilot
-- :help copilot-maps

return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-F>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.g.copilot_no_tab_map = true
  end,
}
