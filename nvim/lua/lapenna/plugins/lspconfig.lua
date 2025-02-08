-- Setup Mason to automatically install LSP servers;
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { exclude = { "pyright" } },
  automatic_installation = false,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities
    }
  end,
}

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}

-- lua
require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "it", "describe", "before_each", "after_each" },
      }
    }
  }
}

require('lspconfig').pyright.setup({
  capabilities = capabilities,
  cmd = { "docker", "exec", "-i", "py-pip", "pyright-langserver", "--stdio" },
  root_dir = function(fname)
    return "/workspace" -- Force root to match inside container
  end,
  settings = {
    python = {
      pythonPath = "/usr/local/bin/python3",
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  on_init = function(client)
    client.config.settings.python.workspaceFolder = "/workspace"
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  end,
})


-- PHP
require('lspconfig').intelephense.setup({ capabilities = capabilities })
-- require'lspconfig'.phpactor.setup({
--   capabilities = capabilities
-- })

-- Vue, JavaScript, TypeScript
require('lspconfig').volar.setup({
  capabilities = capabilities,
  -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
  -- This drastically improves the responsiveness of diagnostic updates on change
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

-- Tailwind CSS
require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

-- JSON
require('lspconfig').jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})

-- null-ls
require('null-ls').setup({
  sources = {
    -- diagnostics

    require("none-ls.diagnostics.eslint"),

    -- require('null-ls').builtins.diagnostics.mypy.with({
    --   command = "docker",
    --   args = {
    --     "run", "--rm", "-v", vim.fn.getcwd() .. ":/app",
    --     "python:3.11",
    --     "sh", "-c", "pip install mypy > /dev/null && mypy /app"
    --   },
    -- }),
    require('none-ls.formatting.ruff'),
    require('none-ls.formatting.ruff_format'),

    require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),

    -- formatting
    require("none-ls.diagnostics.eslint").with({
      condition = function(utils)
        return utils.root_has_file({ '.eslintrc.js' })
      end,
    }),

    require('null-ls').builtins.formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
    require('none-ls.formatting.ruff').with { extra_args = { '--extend-select', 'I' } },
    require 'none-ls.formatting.ruff_format',
  },
})

require('mason-null-ls').setup({
  ensure_installed = {},
  automatic_installation = { exclude = { "mypy", "ruff" } },
})

-- Keymaps
vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
-- vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Commands
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format({
  filter = function(client)
    return client.name == "null-ls"
  end,
  timeout_ms = 5000
}) end, {})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  float = {
    source = true,
  }
})

-- Sign configuration
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
