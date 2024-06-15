--
-- autocmds.lua

-- nvim startup, if no arguments was specified, open telescope find_files()
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Open telescope find_files() on startup',
  group = vim.api.nvim_create_augroup('open-telescope-find_files', { clear = true }),
  callback = function()
    if vim.fn.argv(0) == '' then
      -- this checks prevents error when lazy is doing installs on startup,
      -- where I guess we reach VimEnter but lazy hasn't loaded any plugins yet.
      local package_exists, _ = pcall(require, 'telescope.builtin')
      if package_exists then
        require('telescope.builtin').find_files()
      end
    end
  end,
})

-- highlight when yanking (copying) text
--  try it with `yap` in normal mode
--  see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
