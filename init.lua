require("config.lazy")
vim.cmd[[colorscheme tokyonight-storm]]

vim.api.nvim_create_autocmd({'BufRead', 'BufEnter'}, {
  pattern = '*.*',
  command = 'set number',
})
require("config.keymap")
--функции
vim.api.nvim_create_user_command('TranslateFile', function()
  -- Выделяем весь текст в файле
  vim.cmd('normal! ggVG')

  -- Получаем выделенный текст
  local start_line = vim.fn.line("'<")  -- Начальная строка выделения
  local end_line = vim.fn.line("'>")    -- Конечная строка выделения
  local lines = vim.fn.getline(start_line, end_line)  -- Получаем строки

  -- Объединяем строки в один текст
  local text = table.concat(lines, "\n")

  -- Переводим текст через translate-shell с флагом -b
  local result = vim.fn.system("trans -b :ru " .. vim.fn.shellescape(text))

  -- Показываем результат в уведомлении
  vim.notify(result, vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command('Quit', 'qa!', {})
vim.api.nvim_create_user_command('RunPython', function()
  -- Определяем путь к интерпретатору
  local venv_path = vim.fn.getcwd() .. "/.venv"
  local python_path = vim.fn.executable(venv_path .. "/bin/python") == 1 
    and venv_path .. "/bin/python" 
    or "/usr/bin/python3"

  -- Запускаем скрипт с правvim.opt.guifont = { "Source Code Pro", ":h12" }ильным интерпретатором
  vim.cmd(string.format("split | terminal %s %s", python_path, vim.fn.expand("%")))
  --vim.cmd("q")
end, {})



vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function()
    local venv = vim.fn.getcwd() .. "/.venv"
    if vim.fn.isdirectory(venv) then
      vim.g.python3_host_prog = venv .. "/bin/python"
      vim.notify("Using Python from " .. venv, vim.log.levels.INFO)
    end
  end
})

vim.opt.guifont = { "Hack Nerd Font", ":h11" }
require('mini.pairs').setup()
require('config.lualine')
