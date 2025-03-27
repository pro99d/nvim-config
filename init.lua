require("config.lazy")
vim.cmd[[colorscheme tokyonight-storm]]

vim.api.nvim_create_autocmd({'BufRead', 'BufEnter'}, {
  pattern = '*.*',
  command = 'set number',
})
require('hologram').setup{
    auto_display = true
}
require("plugins.alpha")



vim.api.nvim_create_user_command('Quit', 'wqa!', {})
vim.api.nvim_create_user_command('RunPython', 'split | terminal python3 %', {})


--двойные скобки и кавычки

vim.api.nvim_set_keymap('i', '"', '""<left>', { noremap = true })
vim.api.nvim_set_keymap('i', "'", "''<left>", { noremap = true })
vim.api.nvim_set_keymap('i', '(', "()<left>", { noremap = true })
vim.api.nvim_set_keymap('i', '{', "{}<left>", { noremap = true })
vim.api.nvim_set_keymap('i', '[', "[]<left>", { noremap = true })
vim.api.nvim_set_keymap('i', '«', "«»<left>", { noremap = true })
vim.api.nvim_set_keymap('i', '‹', "‹›<left>", { noremap = true })
vim.api.nvim_set_keymap('i', '<', "<><left>", { noremap = true }) 

--клавиши
vim.api.nvim_set_keymap('t', '<leader><Esc>', "<C-\><C-n>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><F8>', ":'<,'>SnipRun<CR>", { noremap = true, silent = true })


