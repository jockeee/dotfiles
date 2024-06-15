-- --------------------
-- BUFFERLINE
-- ----------------------

-- TODO: you can do this with lualine, they say
-- https://www.reddit.com/r/neovim/comments/16ytwil/does_bufferline_make_any_sense/

-- :h bufferline-configuration
return {
  'akinsho/bufferline.nvim',
  event = 'VimEnter',
  version = '*',
  dependencies = { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- for pretty icons, but requires a nerd font
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
      -- lazyvim style
      diagnostics_indicator = function(_, _, diag, _)
        local ret = (diag.error and ' ' .. diag.error .. ' ' or '') .. (diag.warning and ' ' .. diag.warning or '')
        return vim.trim(ret)
      end,
    },
  },
}
