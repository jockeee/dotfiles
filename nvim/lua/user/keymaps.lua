-- --------------------
-- KEYMAPS
-- --------------------

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- clear highlights (search) with <esc>
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<cr>')

-- exit terminal mode in the builtin terminal with <esc> (default: <C-\><C-n>).
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '`', '<C-\\><C-n><cmd>ToggleTerm direction=float<cr>', { desc = 'Exit terminal' })

-- save file
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- resize window using <ctrl> arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window hidth' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window hidth' })

-- Move Lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- buffers
vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

-- better indenting (gv re-selects last selection)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- diagnostic (https://github.com/neovim/nvim-lspconfig)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })
vim.keymap.set('n', '<leader>m', '<cmd>Mason<cr>', { desc = 'Mason' })

-- neotree
vim.keymap.set('n', '\\', '<cmd>Neotree focus<cr>', { desc = 'Neotree' })

-- --------------------
-- leader-c: code
-- --------------------

-- see lsp-config.lua, nvim-cmp.lua and conform.lua plugins for most of the keymaps related to code

-- --------------------
-- leader-d: document (everything buffer related as well, you don't want to hit b key for it)
-- --------------------

vim.keymap.set('n', '<leader>dd', '<cmd>bdelete<cr>', { desc = 'Buffer delete' })
vim.keymap.set('n', '<leader>dx', '<cmd>bdelete!<cr>', { desc = 'Buffer kill (ignore unsaved changes)' })

-- --------------------
-- leader-f: find
-- --------------------

-- see telescope.lua for most of the keymaps related to finding stuff

-- --------------------
-- leader-g: git
-- --------------------

vim.keymap.set('n', '<leader>g', '<cmd>Neogit<cr>', { desc = 'Neogit' })

-- --------------------
-- leader-q: quit
-- --------------------

vim.keymap.set('n', '<leader>qq', '<cmd>qa!<cr>', { desc = 'qa!' })
vim.keymap.set('n', '<leader>qw', '<cmd>qw!<cr>', { desc = 'qw!' })
