require('lapenna/plugins')
require('lapenna/options')
require('lapenna/keymaps')
require('lapenna/commands')

if vim.fn.exists('$TMUX') == 1 then
  -- Rename tmux window when entering a buffer
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      local filename = vim.fn.expand("%:t")
      vim.fn.system("tmux rename-window '" .. filename .. "'")
    end
  })

  -- Restore tmux automatic window renaming when leaving Vim
  vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
      vim.fn.system("tmux setw automatic-rename")
    end
  })
end
require('lapenna/commands')

