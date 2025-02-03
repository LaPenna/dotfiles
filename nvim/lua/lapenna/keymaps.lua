-- Space is my leader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Swap last two buffers
vim.keymap.set('n', '<leader><Space>', ':b#<CR>', { noremap = true, silent = true })

-- Run current python file inside given docker container
vim.keymap.set('n', '<leader>py', ':w<CR>:!docker exec python-container python %<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p2', ':w<CR>:FloatermToggle<CR> docker exec -it python-container python %<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p3', ':w<CR>:FloatermToggle<CR> docker exec -it python-container python expand("%:t")<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p4', function()
  local filename = vim.fn.expand('%:t') -- Get only the filename
  vim.cmd('w') -- Save the file
  vim.cmd('FloatermToggle') -- Open the floating terminal
  vim.cmd('FloatermSend docker exec python-container python3 /workspace/' .. filename) -- Run command inside it
end, { noremap = true, silent = true })

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

-- Reselect visual selection after indenting.
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- Paste replace visual selection without copying it.
vim.keymap.set('v', 'p', '"_dP')

-- Clear search highlighting.
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Close all open buffers.
vim.keymap.set('n', '<leader>Q', ':bufdo bdelete<CR>:Dashboard<CR>')
vim.keymap.set('n', '<leader>q', ':bd<CR>')

-- Rerun last :command
vim.keymap.set('n', '<leader>:', ':@:<CR>')

-- Diagnostics.
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [d]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [d]iagnostic' })

-- Allow gf to open non-existent files.
vim.keymap.set('', 'gf', ':edit <cfile><CR>')

-- Reselect pasted text
-- vim.keymap.set('n', 'p', 'p`[v`]')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set('i', ';;', '<Esc>A;<Esc>')
vim.keymap.set('i', ',,', '<Esc>A,<Esc>')
-- vim.keymap.set('n', ',,', 'A,<Esc>')
-- vim.keymap.set('n', ';;', 'A;<Esc>')

-- open the current file in the default program (on mac this should just be just `open`).
-- vim.keymap.set('n', '<leader>x', ':!xdg-open %<cr><cr>')

-- Resize with arrows.
-- vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
-- vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
-- vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
-- vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
-- vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
-- vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
-- vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
-- vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
-- vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")

vim.keymap.set("n", "d0", "0D")
