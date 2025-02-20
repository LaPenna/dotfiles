require('dashboard').setup({
  theme = 'doom',
  config = {
    header = {
      '',
      '',
      '',
      ' ▄█          ▄████████         ▄███████▄    ▄████████   ███▄▄▄▄    ███▄▄▄▄      ▄████████ ',
      ' ███         ███    ███        ███    ███   ███    █▀   ███▀▀▀██▄  ███▀▀▀██▄   ███    ███ ',
      ' ███         ███    ███        ███    ███  ▄███▄▄▄      ███   ███  ███   ███   ███    ███ ',
      ' ███       ▀███████████      ▀█████████▀  ▀▀███▀▀▀      ███   ███  ███   ███ ▀███████████ ',
      ' ███▌    ▄   ███    ███        ███          ███    █▄   ███   ███  ███   ███   ███    ███ ',
      ' █████▄▄██   ███    █▀        ▄████▀        ██████████   ▀█   █▀    ▀█   █▀    ███    █▀  ',
      '',
      '',
    },
    center = {
      { icon = '  ', desc = 'New file', action = 'enew' },
      { icon = '  ', desc = 'Find file               ', key = 'Space + f', action = 'Telescope find_files' },
      { icon = '  ', desc = 'Recent files            ', key = 'Space + h', action = 'Telescope oldfiles' },
      { icon = '  ', desc = 'Find Word               ', key = 'Space + g', action = 'Telescope live_grep' },
    },
    footer = { '♥‿♥' }
  },
  hide = {
    statusline = false,
    tabline = false,
    winbar = false,
  }
})

vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#dd479b' })
vim.api.nvim_set_hl(0, 'DashboardDesc', { fg = '#f8f8f2' })
vim.api.nvim_set_hl(0, 'DashboardIcon', { fg = '#dd479b' })
vim.api.nvim_set_hl(0, 'DashboardKey', { fg = '#6272a4' })
vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#dd479b' })
