require("config.lazy")
vim.cmd[[colorscheme tokyonight-storm]]

vim.cmd("set number")
vim.api.nvim_create_autocmd({'BufRead', 'BufEnter'}, {
  pattern = '*',
  command = 'set number',
})
vim.cmd("NERDTree")
require('hologram').setup{
    auto_display = true
}
require("plugins.alpha")

vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    vim.cmd("NERDTree")
  end,
})


vim.cmd("Alpha")

vim.api.nvim_create_user_command('Quit', 'wqa!', {})
vim.api.nvim_create_user_command('RunPython', 'split | terminal python3 %', {})

vim.keymap.set('n', '<leader>as', "LLMSuggestion ", {})
