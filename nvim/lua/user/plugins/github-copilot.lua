--
-- https://github.com/github/copilot.vim
-- Neovim plugin for GitHub Copilot

-- :help copilot
-- :help copilot-maps

return {
  'github/copilot.vim',
  config = function()
    -- accept line
    vim.keymap.set('i', '<C-F>', '<Plug>(copilot-accept-line)')
    -- accept word
    vim.keymap.set('i', '<C-N>', '<Plug>(copilot-accept-word)')
    -- accept suggestion
    vim.keymap.set('i', '<C-G>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
    })
    vim.g.copilot_no_tab_map = true
  end,
}
