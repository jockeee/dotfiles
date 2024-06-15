--
-- options.lua
--
-- :help vim.opt
-- :help option-list
--
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- mouse
vim.opt.mouse = 'a'

-- clipboard
-- sync clipboard between os and neovim
vim.opt.clipboard = 'unnamedplus'

-- appearance
vim.opt.termguicolors = true -- true color support
vim.opt.background = 'dark'
vim.opt.signcolumn = 'yes'
vim.opt.showmode = false
vim.opt.colorcolumn = '' -- right margin column

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs & indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.autoindent = true

-- line wrapping
vim.opt.wrap = false -- default: on
vim.opt.breakindent = true -- wrapped lines will continue visually indented

-- folding
vim.opt.foldcolumn = '1'
vim.opt.foldmethod = 'manual'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true -- default: on

-- search settings
-- case-insensitive searching UNLESS \C or capital in search
vim.opt.hlsearch = true -- highlight search results -- default: on
vim.opt.ignorecase = true
vim.opt.smartcase = true -- don't ignore case with capitals

-- consider - as part of keyword
vim.opt.iskeyword:append '-'

-- how new splits should be opened
vim.opt.splitright = true -- put new windows right of current -- default: off
vim.opt.splitbelow = true -- put new windows below current -- default: off

-- save undo history
vim.opt.undofile = true
vim.opt.undolevels = 1000 -- default: 1000

-- decrease update time
vim.opt.updatetime = 250 -- save swap file and trigger CursorHold
vim.opt.timeoutlen = 300 -- lower than default (1000) to quickly trigger which-key

-- sets how neovim will display certain whitespace in the editor.
vim.opt.list = false -- show invisible characters (tabs...)
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- show which line your cursor is on
vim.opt.cursorline = false -- highlighting of the current line

-- minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10 -- lines of context

-- popupmenu
vim.opt.pumheight = 10 -- maximum number of items to show in the popup menu

-- sessions
-- auto-session plugin suggests these sessionoptions
-- https://github.com/rmagatti/auto-session?tab=readme-ov-file#recommended-sessionoptions-config
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
