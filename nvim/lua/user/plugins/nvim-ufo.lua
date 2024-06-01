--
-- https://github.com/kevinhwang91/nvim-ufo
-- Not UFO in the sky, but an ultra fold in Neovim.

-- folding
return {
  'kevinhwang91/nvim-ufo',
  requires = 'kevinhwang91/promise-async',
  config = function()
    require('nvim-ufo').setup()
  end,
}
