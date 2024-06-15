--
-- https://github.com/stevearc/conform.nvim
-- Lightweight yet powerful formatter plugin for Neovim
--
-- :ConformInfo

return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>df',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't have a well standardized coding style.
      -- You can add additional languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      -- Specify formatters by filetype
      --
      -- Run multiple formatters sequentially
      -- python = { "isort", "black" }
      --
      -- Run *until* a formatter is found
      -- javascript = { { 'prettierd', 'prettier' } }
      bash = { 'shfmt' },
      lua = { 'stylua' },
      html = { { 'prettierd', 'prettier' } },
      javascript = { { 'prettierd', 'prettier' } },
      go = { 'gofumpt', 'goimports-reviser' },
    },
    formatters_by_ext = {
      -- Specify formatters by file extension
      --
      -- ["py"] = { "isort", "black" },
      -- ["js"] = { { 'prettierd', 'prettier' } },
      -- ["ts"] = { { 'prettierd', 'prettier' } },
    },
  },
}
