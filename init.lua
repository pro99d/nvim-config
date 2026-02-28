vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
    },

    { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- Refresh if files in current directory changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "DirChanged" }, {
    group = vim.api.nvim_create_augroup("LspAutoRefresh", { clear = true }),
    callback = function()
        vim.cmd("silent! checktime")
    end,
})

vim.schedule(function()
    require "mappings"
end)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require("todo-comments").setup()
-- Initialize the LSP defaults from the config file
require("configs.lspconfig").defaults()
-- Automatically save session when leaving Neovim
vim.api.nvim_create_autocmd('VimLeave', {
    pattern = '*',
    command = 'mkview'
})

-- Automatically load session if it exists
vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    command = 'loadview'
})

vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*.py',
    command = 'LspStart ty'
})
