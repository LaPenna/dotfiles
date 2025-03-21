-- Setup Mason to automatically install LSP servers;
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    -- "pyright",
  },
  automatic_installation = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
    })
  end,
})

-- require("lspconfig").pyright.setup({})
-- require("lspconfig").basedpyright.setup({
--   capabilities = capabilities,
-- })

require("lspconfig").jedi_language_server.setup({
  capabilities = capabilities,
})

require("lspconfig").jsonls.setup({
  capabilities = capabilities,
})

-- lua
require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "it", "describe", "before_each", "after_each" },
        disable = { "missing-fields" },
      },
    },
  },
})

-- PHP
require("lspconfig").intelephense.setup({ capabilities = capabilities })
-- require'lspconfig'.phpactor.setup({
--   capabilities = capabilities
-- })

-- Vue, JavaScript, TypeScript
require("lspconfig").volar.setup({
  capabilities = capabilities,
  -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
  -- This drastically improves the responsiveness of diagnostic updates on change
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

-- Tailwind CSS
require("lspconfig").tailwindcss.setup({ capabilities = capabilities })

-- JSON
require("lspconfig").jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
})

-- null-ls
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
  -- Call :Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.cmd("Format") -- Run :Format instead of vim.lsp.buf.format()
        end,
      })
    end
  end,
  sources = {
    -- Global
    require("null-ls").builtins.diagnostics.trail_space.with({ disabled_filetypes = { "NvimTree" } }),

    -- JS
    require("none-ls.diagnostics.eslint"),

    require("none-ls.diagnostics.eslint").with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js" })
      end,
    }),

    -- Prettier
    require("null-ls").builtins.formatting.prettier.with({ filetypes = { "html", "json", "yaml", "markdown" } }),
    require("null-ls").builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),

    -- Python
    -- require("null-ls.builtins.diagnostics.mypy"),
    -- require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
    -- require("none-ls.formatting.ruff_format"),
    require("null-ls").builtins.formatting.black,
  },
})

require("mason-null-ls").setup({
  ensure_installed = {},
  automatic_installation = { exclude = {} },
})

-- Keymaps
vim.keymap.set("n", "<Leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

-- Commands
vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format({
    filter = function(client)
      return client.name == "null-ls"
    end,
    timeout_ms = 5000,
  })
end, {})

-- Format on saves

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  float = {
    source = true,
  },
})

-- Sign configuration
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
