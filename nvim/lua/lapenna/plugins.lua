local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use
use 'wbthomason/packer.nvim'

-- My plugins here

-- -- Theme
use {"tiagovla/tokyodark.nvim"}
-- vim.cmd [[colorscheme tokyodark]]

use {
  "scottmckendry/cyberdream.nvim",
  config = function ()
    require("cyberdream").setup({
        -- Set light or dark variant
        variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
        transparent = false,
        italic_comments = true,
        hide_fillchars = false,
        borderless_pickers = false,
      })
      vim.cmd [[colorscheme tokyodark]]
  end
}

-- catpuccinn
-- use {
--   "catppuccin/nvim",
--   as = "catppuccin",
--   require("catppuccin").setup({
--     flavour = "mocha", -- latte, frappe, macchiato, mocha
--     background = { -- :h background
--       light = "mocha",
--       dark = "mocha",
--     },
--     transparent_background = true, -- disables setting the background color.
--     show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--     term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--     dim_inactive = {
--       enabled = false, -- dims the background color of inactive window
--       shade = "dark",
--       percentage = 0.15, -- percentage of the shade to apply to the inactive window
--     },
--     no_italic = false, -- Force no italic
--     no_bold = false, -- Force no bold
--     no_underline = false, -- Force no underline
--     styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--       comments = { "italic" }, -- Change the style of comments
--       conditionals = { "italic" },
--       loops = {},
--       functions = {},
--       keywords = {},
--       strings = {},
--       variables = {},
--       numbers = {},
--       booleans = {},
--       properties = {},
--       types = {},
--       operators = {},
--       -- miscs = {}, -- Uncomment to turn off hard-coded styles
--     },
--     color_overrides = {},
--     custom_highlights = {},
--     default_integrations = true,
--     integrations = {
--       cmp = true,
--       gitsigns = true,
--       nvimtree = true,
--       treesitter = true,
--       notify = false,
--       mini = {
--         enabled = true,
--         indentscope_color = "",
--       },
--       -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--     },
--   }),
--   -- setup must be called before loading
--   vim.cmd.colorscheme "catppuccin"
-- }

use {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('lapenna/plugins/dashboard-nvim')
  end,
  requires = {'nvim-tree/nvim-web-devicons'}
}

-- Custom status line
use ({
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require('lapenna/plugins/lualine')
  end,
})

-- Commenting support.
use({
  'tpope/vim-commentary',
  config = function()
    -- Maintain cursor position
    vim.keymap.set('n', 'gcap', 'my<cmd>norm vip<bar>gc<cr>`y')
  end,
})

-- Add, change and delete surrounding text
use('tpope/vim-surround')

-- Useful commands like  :Rename and :SudoWrite
use('tpope/vim-eunuch')

-- Pairs of handy bracket pairings like [b and ]b
use('tpope/vim-unimpaired')

-- Indent autodetection with editorconfig support.
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating of commands.
use('tpope/vim-repeat')

-- Write a file containing the current state of Vim
use('tpope/vim-obsession')

-- Navigate seamlessly between Vim windows and Tmux panes.
use('christoomey/vim-tmux-navigator')

-- Jump to the last location when opening a file.
use('farmergreg/vim-lastplace')

-- Enable * searching with visually selected text.
use('nelstrom/vim-visual-star-search')

-- Automatically create parent dirs when saving.
use('jessarcher/vim-heritage')

-- Text objects for HTML attributes.
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',
})

-- Automatically set the working directory to the project root.
use({
  'airblade/vim-rooter',
  setup = function()
    -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
    vim.g.rooter_manual_only = 1
    vim.g.rooter_patterns = {'.git', 'composer.json'}
  end,
  config = function()
    vim.cmd('Rooter')
  end,
})

-- Split arrays and methods onto multiple lines, or join them back up.
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

-- Automatically fix indentation when pasting code.
use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

-- Fuzzy finder
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'nvim-telescope/telescope-live-grep-args.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  },
  config = function()
    require('lapenna/plugins/telescope')
  end,
})

-- File tree sidebare
use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('lapenna/plugins/nvim-tree')
  end,
})

use({
  'numToStr/FTerm.nvim',
  config = function()
    require('lapenna/plugins/fterm')
  end,
})

-- use {"akinsho/toggleterm.nvim", tag = '*', config = function()
--   require("toggleterm").setup{
--     start_in_insert = false,
--     persist_mode = true,
--     direction = 'float',
--     size = function(term)
--       if term.direction == "horizontal" then
--         return 15
--       elseif term.direction == "vertical" then
--         return vim.o.columns * 0.4
--       end
--     end,
--     float_opts = {
--       border = 'curved',
--       width = math.floor(0.9 * vim.fn.winwidth(0)),
--       height = math.floor(0.8 * vim.fn.winheight(0)),
--     }
--   }

--   vim.keymap.set('n', "<leader>'", ':ToggleTerm<CR>:startinsert<CR>')
--   vim.keymap.set('t', '<Esc>', '<C-\\><C-n>:ToggleTerm<CR>')
-- end}

-- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  requires = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('lapenna/plugins/treesitter')
  end,
})

use {
  'abecodes/tabout.nvim',
  config = function()
    require('tabout').setup {
      tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
      backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
      act_as_tab = true, -- shift content if tab out is not possible
      act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
      default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
      default_shift_tab = '<C-d>', -- reverse shift default action,
      enable_backwards = true, -- well ...
      completion = true, -- if the tabkey is used in a completion pum
      tabouts = {
        {open = "'", close = "'"},
        {open = '"', close = '"'},
        {open = '`', close = '`'},
        {open = '(', close = ')'},
        {open = '[', close = ']'},
        {open = '{', close = '}'}
      },
      ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      exclude = {} -- tabout will ignore these filetypes
    }
  end,
  wants = {'nvim-treesitter'} -- (optional) or require if not used so far
  -- after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
}

-- Language Server Protocol.
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    'nvimtools/none-ls.nvim',
    "nvimtools/none-ls-extras.nvim",
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    require('lapenna/plugins/lspconfig')
  end,
})

-- Completion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    require('lapenna/plugins/cmp')
  end,
})

-- Lua support for nvim configs
use {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  config = function()
    require("lazydev").setup {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    }
  end
}

-- PHP Refactoring Tools
use({
  'phpactor/phpactor',
  -- ft = 'php',
  run = 'composer install --no-dev --optimize-autoloader',
  config = function()
    vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
    vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
  end,
})

-- Project Configuration
use({
  'tpope/vim-projectionist',
  required = 'tpope/vim-dispatch',
  config = function ()
    require('lapenna/plugins/projectionist')
  end,
})

use({ "cohama/lexima.vim" })

-- Add smooth scrolling to avoid jarring jumps
use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
  end,
})

use({
  'sphamba/smear-cursor.nvim',
  config = function()
    require('smear_cursor').setup()
  end,
})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
  require('packer').sync()
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile>
augroup end
]])
