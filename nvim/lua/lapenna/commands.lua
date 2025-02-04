vim.api.nvim_create_user_command('Q', 'q!', {})
vim.api.nvim_create_user_command('E', 'e!', {})
vim.api.nvim_create_user_command('PS', ':PackerSync', {})
vim.api.nvim_create_user_command('PC', ':PackerCompile', {})
