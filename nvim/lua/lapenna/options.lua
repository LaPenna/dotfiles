vim.opt.termguicolors = true
vim.opt.title = true

vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wildmode = 'longest:full,full' -- easier tabbing autocomplete commands
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

-- Cursor sticks to center
-- vim.keymap.set('n', 'j', 'jzz', { noremap = true })
-- vim.keymap.set('n', 'k', 'kzz', { noremap = true })

print('options loaded')
