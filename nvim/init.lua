require('lapenna/plugins')
require('lapenna/options')
require('lapenna/keymaps')
require('lapenna/commands')

-- From Deepseek
-- init.lua
local lspconfig = require('lspconfig')
local cmp = require('cmp')

-- Setup nvim-cmp.
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

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
