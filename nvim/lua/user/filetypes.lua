--
-- filetypes.lua

-- .templ
-- https://templ.guide/commands-and-tools/ide-support/#neovim--050
vim.filetype.add { extension = { templ = 'templ' } }

-- .gohtml
local ft = vim.api.nvim_create_augroup('filetype_gohtml', { clear = true })
vim.api.nvim_create_autocmd('filetype', {
  group = ft,
  pattern = '.gohtml',
  callback = function()
    vim.bo.filetype = 'html'
  end,
})
