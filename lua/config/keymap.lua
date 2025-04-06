

-- Для режима вставки (Insert Mode)
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-o>db', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Del>', '<C-o>dw', { noremap = true, silent = true })


vim.api.nvim_set_keymap('i', '<C-Left>', '<C-o>b', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-Right>', '<C-o>w', { noremap = true })

vim.api.nvim_set_keymap('n', '<F6>', ':SnipRun<CR>', { noremap = true })

vim.api.nvim_set_keymap(  't'  ,  '<Leader><ESC>'  ,  '<C-\\><C-n>'  ,  {noremap = true}  ) 
vim.api.nvim_set_keymap('n', '<leader><F8>', ":'<,'>SnipRun<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ":TranslateFile", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<C-c>', "\"+y", {noremap = true, silent = true})
