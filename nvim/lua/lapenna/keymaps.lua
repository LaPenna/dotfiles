-- Space is my leader.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Centre the editor when going to last line
vim.keymap.set("n", "G", "Gzz")

-- Swap last two buffers
vim.keymap.set("n", "<leader><Space>", ":b#<CR>", { noremap = true, silent = true })

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-- Reselect visual selection after indenting.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

-- Paste replace visual selection without copying it.
vim.keymap.set("v", "p", '"_dP')

-- Clear search highlighting.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Close all open buffers.
vim.keymap.set("n", "<leader>Q", ":bufdo bdelete<CR>:Dashboard<CR>")
vim.keymap.set("n", "<leader>q", ":bd<CR>")

-- Rerun last :command
vim.keymap.set("n", "<leader>:", ":@:<CR>")

-- Diagnostics.
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [d]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [d]iagnostic" })

-- Allow gf to open non-existent files.
vim.keymap.set("", "gf", ":edit <cfile><CR>")

-- Reselect pasted text
-- vim.keymap.set('n', 'p', 'p`[v`]')

-- Easy insertion of a trailing ; or , from insert mode.
vim.keymap.set("i", ";;", "<Esc>A;<Esc>")
vim.keymap.set("i", ",,", "<Esc>A,<Esc>")
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
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:move .-2<CR>==gi")
-- vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
-- vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
-- vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
-- vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
-- vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")

vim.keymap.set("n", "d0", "0D")

-- Cursor sticks to center
-- vim.keymap.set('n', 'j', 'jzz', { noremap = true })
-- vim.keymap.set('n', 'k', 'kzz', { noremap = true })

-- Run current python file in floating term
vim.keymap.set("n", "<leader>py", function()
  local filename = vim.fn.expand("%:t") -- Get only the filename
  vim.cmd("w") -- Save the file

  -- Open the FTerm terminal
  local fterm = require("FTerm")
  fterm.toggle()

  -- Send the command to the terminal
  local cmd = "python3 " .. filename
  vim.api.nvim_feedkeys(cmd, "n", false) -- Send the command to the terminal
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false) -- Send <CR>
end, { noremap = true, silent = true })

-- Run current python file inside given docker container
vim.keymap.set("n", "<leader>dpy", function()
  local filename = vim.fn.expand("%:t") -- Get only the filename
  vim.cmd("w") -- Save the file

  -- Open the FTerm terminal
  local fterm = require("FTerm")
  fterm.toggle()

  -- Send the command to the terminal
  local cmd = "docker exec -it py-pip python3 /workspace/" .. filename
  vim.api.nvim_feedkeys(cmd, "n", false) -- Send the command to the terminal
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false) -- Send <CR>
end, { noremap = true, silent = true })

-- Install a pip package in our persisted py-pip container
vim.keymap.set("n", "<leader>dpi", function()
  local package = vim.fn.input("Enter package name: ")
  local fterm = require("FTerm")
  fterm.toggle()

  -- Send the command to the terminal
  local cmd = "docker exec -it py-pip pip install " .. package
  vim.api.nvim_feedkeys(cmd, "n", false) -- Send the command to the terminal
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false) -- Send <CR>
end, { noremap = true, silent = true })
