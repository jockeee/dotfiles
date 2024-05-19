-- --------------------
-- TODO-COMMENTS
-- --------------------

-- keywords
--   FIX = alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
--   TODO
--   HACK
--   WARN = alt = { "WARNING", "XXX" }
--   PERF = alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" }
--   NOTE = alt = { "INFO" }
--   TEST = alt = { "TESTING", "PASSED", "FAILED" }

-- highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = false, -- show icons in the signs column
  },
}
