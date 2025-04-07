coc-settings.json:
```json
{
  "pyright.disableLanguageServices": false,
  "pyright.disableOrganizeImports": false,
  "python.pythonPath": "${workspaceFolder}/.venv/bin/python",
  "pyright.useLibraryCodeForTypes": true
}
```
lazy-lock.json:
```json
{
  "LuaSnip": { "branch": "master", "commit": "c9b9a22904c97d0eb69ccb9bab76037838326817" },
  "alpha-nvim": { "branch": "main", "commit": "de72250e054e5e691b9736ee30db72c65d560771" },
  "cmp-buffer": { "branch": "main", "commit": "b74fab3656eea9de20a9b8116afa3cfc4ec09657" },
  "cmp-nvim-lsp": { "branch": "main", "commit": "a8912b88ce488f411177fc8aed358b04dc246d7b" },
  "cmp-path": { "branch": "main", "commit": "c6635aae33a50d6010bf1aa756ac2398a2d54c32" },
  "cmp_luasnip": { "branch": "master", "commit": "98d9cb5c2c38532bd9bdb481067b20fea8f32e90" },
  "fzf-lua": { "branch": "main", "commit": "98fb51f2820ead2f8e3c37a7071d7a113b07e2c1" },
  "hydrovim": { "branch": "main", "commit": "509516bd99fa41f707f86e46f56e0d605290a6b5" },
  "lazy.nvim": { "branch": "main", "commit": "6c3bda4aca61a13a9c63f1c1d1b16b9d3be90d7a" },
  "leetcode.nvim": { "branch": "master", "commit": "db7e1cd6b9191b34b4c1f2f96e4e3949cde9f951" },
  "lualine.nvim": { "branch": "master", "commit": "7de0a690bc1878dd6fc347c599a19a0f34f48dec" },
  "markdown-preview.nvim": { "branch": "master", "commit": "a923f5fc5ba36a3b17e289dc35dc17f66d0548ee" },
  "mason.nvim": { "branch": "main", "commit": "fc98833b6da5de5a9c5b1446ac541577059555be" },
  "mini.pairs": { "branch": "main", "commit": "69864a2efb36c030877421634487fd90db1e4298" },
  "neaterm.nvim": { "branch": "stable", "commit": "09b0aef5b717f55eb9bf9e22c928ad7d4ae8b405" },
  "nerdtree": { "branch": "master", "commit": "9b465acb2745beb988eff3c1e4aa75f349738230" },
  "nerdtree-git-plugin": { "branch": "master", "commit": "e1fe727127a813095854a5b063c15e955a77eafb" },
  "nui.nvim": { "branch": "main", "commit": "8d3bce9764e627b62b07424e0df77f680d47ffdb" },
  "null-ls.nvim": { "branch": "main", "commit": "0010ea927ab7c09ef0ce9bf28c2b573fc302f5a7" },
  "nvim-cmp": { "branch": "main", "commit": "059e89495b3ec09395262f16b1ad441a38081d04" },
  "nvim-lspconfig": { "branch": "master", "commit": "d3ad666b7895f958d088cceb6f6c199672c404fe" },
  "nvim-treesitter": { "branch": "master", "commit": "205faba1768a6e4c854f156bc6a21a41b242599c" },
  "nvim-web-devicons": { "branch": "master", "commit": "481bdaa3dca70c5f1863e634db6afede8980488c" },
  "plenary.nvim": { "branch": "master", "commit": "857c5ac632080dba10aae49dba902ce3abf91b35" },
  "project.nvim": { "branch": "main", "commit": "8c6bad7d22eef1b71144b401c9f74ed01526a4fb" },
  "sniprun": { "branch": "master", "commit": "151ada2c984aee1feb45c7e3c2abb19f597ecbd0" },
  "telescope.nvim": { "branch": "master", "commit": "a4ed82509cecc56df1c7138920a1aeaf246c0ac5" },
  "tokyonight.nvim": { "branch": "main", "commit": "057ef5d260c1931f1dffd0f052c685dcd14100a3" },
  "which-key.nvim": { "branch": "main", "commit": "370ec46f710e058c9c1646273e6b225acf47cbed" }
}
```
init.lua:
```lua
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
```
lua/config/keymap.lua:
```lua


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
```
lua/config/sniprun.lua:
```lua
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
```
lua/config/lazy.lua:
```lua
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
    
  },
  --install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
```
lua/config/cmp.lua:
```lua
-- lua/config/cmp.lua
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<CR>"] = cmp.mapping.confirm({ 
      select = true, 
      behavior = cmp.ConfirmBehavior.Replace 
    }),
  },
  
  -- Остальные настройки остаются без изменений
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})
```
lua/config/options.lua:
```lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
```
lua/plugins/alpha.lua:
```lua
return {
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },  -- Для иконок
    config = function()
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___   ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\ ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      }
      dashboard.section.buttons.val = {
        dashboard.button('f', 'Найти файл', ':Telescope find_files <CR>'),
        dashboard.button('e', 'Новый Файл', ':ene <BAR> startinsert <CR>'),
        dashboard.button('r', 'Недавно открытые', ':Telescope oldfiles <CR>'),
        dashboard.button('s', 'Сессия', ':SessionLoad <CR>'),
        dashboard.button('c', 'Редактировать конфиг', ':e $MYVIMRC <CR>'),
        dashboard.button('q', 'Выход', ':qa!<CR>'),
      }
      require('alpha').setup(dashboard.config)
    end,
  },
}
```
lua/plugins/main.lua:
```lua
return {
  {"folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}},
  {"nvim-tree/nvim-web-devicons", opts = {}},
  "nvim-telescope/telescope.nvim",
  "smzm/hydrovim",
  "nvim-lualine/lualine.nvim",
  {
    "Dan7h3x/neaterm.nvim",
    branch = "stable",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ibhagwan/fzf-lua"
    }
  },
  "preservim/nerdtree",
  "Xuyuanp/nerdtree-git-plugin",
  --"edluffy/hologram.nvim",
  "echasnovski/mini.pairs",
  {
    "williamboman/mason.nvim",
    config = true
  },
{
  "neovim/nvim-lspconfig",
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require('lspconfig').pyright.setup{
      capabilities = capabilities,
      on_attach = function(client)
        client.server_capabilities.textDocument_sync = {
          change = { notification = "textDocument/didChange" }
        }
      end
    }
  end
},
"hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  {
    "michaelb/sniprun",
    branch = "master",
    build = "sh install.sh",
    config = function()
      require("sniprun").setup({})
    end
  },
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = "lua",
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    })
  end,
},
{
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  ft = {"markdown"},             
},
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      --"huggingface/llm.nvim",
    },
    config = function()
      local cmp = require('cmp')
      --[[
      local llm = require('llm')
      llm.setup({
          backend = "openai",
          model = "qwen2.5-7b-instruct-1m",
          url = "http://localhost:1234", -- llm-ls uses "/v1/completions"
          -- cf https://github.com/abetlen/llama-cpp-python?tab=readme-ov-file#openai-compatible-web-server
          request_body = {
            temperature = 0.2,
            top_p = 0.95,
          }
        })]]--
      
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip' }
        }),
        mapping = {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' })
        }
      })
    end
  },
} 
```
lua/plugins/project.lua:
```lua
return {
  {
    "ahmedkhalf/project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
        patterns = { ".git", "package.json", "Makefile", ".sln", "README.md", ".venv" },
        show_hidden = true,
        silent_chdir = true,
      })
      require("telescope").load_extension("projects")
    end,
    event = "VeryLazy",
  }
}
```
lua/plugins/ui.lua:
```lua

return {{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},}
```
lua/plugins/lsp.lua:
```lua
return {}
```
lua/plugins/leetcode.lua:
```lua
return {
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      ---@type string
      arg = "leetcode.nvim",

      ---@type lc.lang
      lang = "python3",

      cn = { -- leetcode.cn
        enabled = false, ---@type boolean
        translator = true, ---@type boolean
        translate_problems = true, ---@type boolean
      },

      ---@type lc.storage
      storage = {
        home = vim.fn.stdpath("data") .. "/leetcode",
        cache = vim.fn.stdpath("cache") .. "/leetcode",
      },

      ---@type table<string, boolean>
      plugins = {
        non_standalone = false,
      },

      ---@type boolean
      logging = true,

      injector = {}, ---@type table<lc.lang, lc.inject>

      cache = {
        update_interval = 60 * 60 * 24 * 7, ---@type integer 7 days
      },

      console = {
        open_on_runcode = true, ---@type boolean

        dir = "row", ---@type lc.direction

        size = { ---@type lc.size
          width = "90%",
          height = "75%",
        },

        result = {
          size = "60%", ---@type lc.size
        },

        testcase = {
          virt_text = true, ---@type boolean

          size = "40%", ---@type lc.size
        },
      },

      description = {
        position = "left", ---@type lc.position

        width = "40%", ---@type lc.size

        show_stats = true, ---@type boolean
      },

      ---@type lc.picker
      picker = { provider = nil },

      hooks = {
        ---@type fun()[]
        ["enter"] = {},

        ---@type fun(question: lc.ui.Question)[]
        ["question_enter"] = {},

        ---@type fun()[]
        ["leave"] = {},
      },

      keys = {
        toggle = { "q" }, ---@type string|string[]
        confirm = { "<CR>" }, ---@type string|string[]

        reset_testcases = "r", ---@type string
        use_testcase = "U", ---@type string
        focus_testcases = "H", ---@type string
        focus_result = "L", ---@type string
      },

      ---@type lc.highlights
      theme = {},

      ---@type boolean
      image_support = false,
    }, -- <-- Закрывающая скобка для opts
  },
}   
```
to_one.py:
```py
from pathlib import Path

name = "fil.md"

def process_directory(directory):
    files = {}  # Словарь для хранения результатов

    for item in directory.iterdir():
        if item.name.startswith('.'):  # Игнорируем скрытые файлы и папки
            continue

        if item.is_file():  # Если это файл
            try:
                with open(item, "r") as file:
                    content = file.read()
                files[str(item)] = content
            except Exception as e:
                print(f"Ошибка при чтении файла {item}: {e}")

        elif item.is_dir():  # Если это директория
            print(f"Обрабатывается директория: {item}")
            # Рекурсивно обрабатываем поддиректорию
            files.update(process_directory(item))

    return files

def fil(root_dir):
    root_path = Path(root_dir)

    if not root_path.exists():
        print(f"Директория {root_dir} не существует.")
        return {}

    return process_directory(root_path)

if __name__ == "__main__":
    root_dir = "."
    files = fil(root_dir)
    
    # Открываем файл fil.md ОДИН РАЗ для записи всего содержимого
    with open(name, "w") as fi:
        for file_path, content in files.items():
            fi.write(f"{file_path}:\n```{file_path.split('.')[-1]}\n{content}```\n")
```
README.md:
```md
# nvim-config

```
