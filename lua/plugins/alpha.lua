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
