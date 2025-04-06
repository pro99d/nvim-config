-- В config/sniprun.lua
require'sniprun'.setup({
  interpreter_options = {
    Python3 = {
      interpreter = function()
        local venv = vim.fn.getcwd() .. "/.venv"
        return vim.fn.isdirectory(venv) == 1 and venv .. "/bin/python" or "python3"
      end
    },
  },
})
