  require('FTerm').setup{
    dimensions = {
      height = 0.9,
      width = 0.9,
    },
    blend = 4,
    border = { "╓", "─", "╖", "║", "╜", "─", "╙", "║" }
    -- border = { "◇", "═", "◇", "║", "◇", "═", "◇", "║" }
    -- border = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠇" }
    -- border = { "⣿", "⠿", "⣿", "⠛", "⠿", "⠿", "⠿", "⠛" }
  }

  vim.keymap.set('n', "<leader>'", '<CMD>lua require("FTerm").toggle()<CR>')
  vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8e8edd", bold = true })
