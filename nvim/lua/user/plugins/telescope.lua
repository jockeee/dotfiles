-- --------------------
-- TELESCOPE
-- --------------------

-- Telescope is a fuzzy finder that comes with a lot of different things that
-- it can fuzzy find! It's more than just a "file finder", it can search
-- many different aspects of Neovim, your workspace, LSP, and more!

-- The easiest way to use telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- After running this command, a window will open up and you're able to
-- type in the prompt window. You'll see a list of help_tags options and
-- a corresponding preview of the help.
--
-- Two important keymaps to use while in telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!

-- TODO: mouse support
-- mouse support is enabled and merged, look into it, LazyVim uses it, it works in his setup.
--
--  feat(scrolling and mouse support): support scrolling and selecting with the mouse
--  https://github.com/nvim-telescope/telescope.nvim/pull/2687
--
--  looks like it will be in next release, current is v0.1.6 from 3 weeks ago.
--  the commits happening now, addressing this, is from 1-2 days ago, just wait for the next release.

-- telescope alaternative?
-- https://github.com/ibhagwan/fzf-lua

-- fuzzy finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { -- If encountering errors, see telescope-fzf-native README for install instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    -- telescope-ui-select sets vim.ui.select to telescope.
    -- That means for example that neovim core stuff can fill the telescope picker.
    -- Example would be lua vim.lsp.buf.code_action().
    -- see how it looks before here (yt typecraft): https://youtu.be/S-xzYgTLVJE?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&t=751
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- for pretty icons, but requires a nerd font

    -- include/exclude files in telescope live grep
    -- https://www.reddit.com/r/neovim/comments/11ukbgn/how_to_includeexclude_files_in_telescope_live_grep/
    -- telescope-live-grep-args to pass arguments to ripgrep
    --  https://github.com/nvim-telescope/telescope-live-grep-args.nvim
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        file_ignore_patterns = {
          -- '%.lockb', -- hides buns binary lock file from the results
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading', -- don't group matches by each file
          '--with-filename',
          '--line-number',
          '--column', -- show column numbers
          '--smart-case',

          -- extra below, makes it behave kind of like `telescope.builtin.git_files` but everywhere, you like it
          '--follow', -- follow symbolic links
          '--hidden', -- search in hidden files (dotfiles)
          -- '--no-ignore-vcs', -- don't exclude files specified in .gitignore

          -- alternative to below, use .ignore file, but you prefer this way
          -- `--hidden` will still show the inside of `.git/` as it's not `.gitignore`d.
          -- exclude the following patterns from search
          '--glob=!**/.git/*',
          -- '--glob=!**/.idea/*',
          -- '--glob=!**/.vscode/*',
          -- '--glob=!**/build/*',
          -- '--glob=!**/dist/*',
          '--glob=!**/yarn.lock',
          '--glob=!**/package-lock.json',
        },
        -- mappings = {
        --   i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        -- },
      },
      pickers = {
        find_files = {
          hidden = true, -- default: false

          -- alternative to below, use .ignore file, but you prefer this way
          -- `hidden = true` will still show the inside of `.git/` as it's not in `.gitignore`.
          -- exclude files & dirs not included or specified in .gitignore
          find_command = {
            'rg',
            '--files',

            -- extra below, makes it behave kind of like `telescope.builtin.git_files` but everywhere, you like it
            '--hidden',
            '--glob=!**/.git/*',
            -- '--glob=!**/.idea/*',
            -- '--glob=!**/.vscode/*',
            -- '--glob=!**/build/*',
            -- '--glob=!**/dist/*',
            '--glob=!**/yarn.lock',
            '--glob=!**/package-lock.json',
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- --------------------
    -- KEYMAPS
    -- --------------------

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader><leader>', builtin.git_files, { desc = 'Find git file' })

    -- find in current buffer
    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0, -- transparency
        previewer = false,
      })
    end, { desc = 'Find in current buffer' })

    -- grep in open files
    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep Open Files',
      }
    end, { desc = 'Find in open files' })

    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffer' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find diagnostics' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find file' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Find by grep' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymap' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find old (recent) file' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find resume' })
    vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'Find select telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })

    -- find nvim config files
    -- vim.keymap.set('n', '<leader>fc', function()
    --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
    -- end, { desc = 'Find nvim config files' })
  end,
}

-- https://stackoverflow.com/questions/71809098/how-to-include-specific-hidden-file-folder-in-search-result-when-using-telescope
-- this is from above link, you like it, exanding on the defaults, instead of hardcoding everything.
-- local telescope = require("telescope")
-- local telescopeConfig = require("telescope.config")
--
-- -- Clone the default Telescope configuration
-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
--
-- -- I want to search in hidden/dot files.
-- table.insert(vimgrep_arguments, "--hidden")
-- -- I don't want to search in the `.git` directory.
-- table.insert(vimgrep_arguments, "--glob")
-- table.insert(vimgrep_arguments, "!**/.git/*")
--
-- telescope.setup({
--   defaults = {
--     -- `hidden = true` is not supported in text grep commands.
--         hidden = true,
--     vimgrep_arguments = vimgrep_arguments,
--   },
--   pickers = {
--     find_files= {
--             hidden = true,
--       -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
--       find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
--     },
--    },
-- })
-- ----- This activates the search for hidden files in live_grep
-- require("telescope").setup {
--      pickers = {
--           live_grep = {
--              additional_args = function(_ts)
--                  return {"--hidden"}
--              end
--           },
--      },
--   }

-- leader find help > tele find files
-- {hidden}             (boolean)   determines whether to show hidden files or not (default: false)
-- {no_ignore}          (boolean)   show files ignored by .gitignore, .ignore, etc. (default: false)
-- {no_ignore_parent}   (boolean)   show files ignored by .gitignore, .ignore, etc. in parent dirs. (default: false)

-- leader find help > tele def vimgrep
-- Telescope uses ripgrep to search through files.
-- By default, ripgrep ignores several groups of files, including hidden files (dotfiles) and files ignored by git.
-- Adding --no-ignore-vcs and --hidden flags will make it to search through those files.
--
--   *telescope.defaults.vimgrep_arguments*
-- vimgrep_arguments:
--     Defines the command that will be used for `live_grep` and `grep_string`
--     pickers.
--     Hint: Make sure that color is currently set to `never` because we do
--     not yet interpret color codes
--     Hint 2: Make sure that these options are in your changes arguments:
--       "--no-heading", "--with-filename", "--line-number", "--column"
--     because we need them so the ripgrep output is in the correct format.
--
--     Default: {
--       "rg",
--       "--color=never",
--       "--no-heading",
--       "--with-filename",
--       "--line-number",
--       "--column",
--       "--smart-case"
--     }
