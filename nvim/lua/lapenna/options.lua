vim.opt.termguicolors = true
vim.opt.title = true

vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 2
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = 'longest:full,full' -- easier tabbing autocomplete commands
vim.opt.completeopt = 'menuone,longest,preview'
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.mouse = 'a'

vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣' }
vim.opt.fillchars:append({ eob = ' ' })

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.clipboard = 'unnamedplus' -- use system clipboard default

vim.opt.inccommand = 'split' -- preview subtitutions as you type

vim.opt.confirm = true -- ask to save file instead of error
vim.opt.undofile = true

vim.opt.signcolumn = 'yes:2'

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd[[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]]
