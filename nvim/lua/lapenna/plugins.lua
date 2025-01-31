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

-- Theme
use({
  'yashguptaz/calvera-dark.nvim',
  config = function()
    -- Optional Example Configuration
    vim.g.calvera_italic_keywords = true
    vim.g.calvera_italic_comments = true
    vim.g.calvera_borders = false
    vim.g.calvera_contrast = true
    vim.g.calvera_hide_eob = true
    vim.g.calvera_custom_colors = {contrast = "#1ce1ce"}

    require('calvera').set()

    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#080818" }) -- Replace with your desired background color
    -- vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#a9b1d6", bg = "#1e1e2e" }) -- Optional: style the border
    -- vim.api.nvim_set_hl(0, 'FloatBorder', {
    --   fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    --   bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    -- })

    vim.api.nvim_set_hl(0, 'CursorLineBg', {
      fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
      bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    })
  end,
})

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
  after = 'calvera-dark.nvim',
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
  after = 'calvera-dark.nvim',
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
  'voldikss/vim-floaterm',
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.keymap.set('n', "<leader>'", ':FloatermToggle<CR>')
    vim.keymap.set('t', "<esc>", '<C-\\><C-n>:FloatermToggle<CR>')
  end,
})

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
    'jose-elias-alvarez/null-ls.nvim',
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

-- use({
--   "gbprod/phpactor.nvim",
--   run = function()
--     require("phpactor.handler.update")()
--   end,
--   requires = {
--     { "nvim-lua/plenary.nvim" },
--     { "neovim/nvim-lspconfig" }
--   },
--   config = function()
--     require("phpactor").setup({
--       install = {
--         bin = '/usr/local/bin/phpactor'
--       },
--       lspconfig = {
--         enabled = true,
--         options = {},
--       },
--     })
--   end,
-- })

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
