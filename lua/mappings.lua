require "nvchad.mappings"
-- add yours here

local map = vim.keymap.set
local options = { noremap = true, silent = true }
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>", options)
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", options)
map({ 'n', 'v' }, "\\", "<cmd> NvimTreeToggle<CR>", options)
map({ "n", "t", "v" }, "<C-left>", "<C-w>>")
map({ "n", "t", "v" }, "<C-up>", "<C-w>+")
map({ "n", "t", "v" }, "<C-right>", "<C-w><")
map({ "n", "t", "v" }, "<C-down>", "<C-w>-")
map("i", "<C-left>", "<ESC>bi", options)
map("i", "<C-right>", "<ESC>wi", options)
map("i", "<C-BS>", "<ESC>dbi")
map("i", "<C-DEL>", "<ESC>dwi")
-- map("n", "<C")
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function insert_lines_below(count)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    count = math.max(1, tonumber(count) or 1)
    -- insert count empty lines after current line using buffer API
    local bufnr = vim.api.nvim_get_current_buf()
    local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""
    local empties = {}
    for _ = 1, count do empties[#empties + 1] = "" end
    -- insert after current line
    vim.api.nvim_buf_set_lines(bufnr, row, row, false, empties)
    vim.api.nvim_win_set_cursor(0, { row, col })
end

local function insert_lines_above(count)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    count = math.max(1, tonumber(count) or 1)
    local bufnr = vim.api.nvim_get_current_buf()
    local empties = {}
    for _ = 1, count do empties[#empties + 1] = "" end
    -- insert before current line
    vim.api.nvim_buf_set_lines(bufnr, row - 1, row - 1, false, empties)
    -- keep cursor on original line (now shifted down by count)
    vim.api.nvim_win_set_cursor(0, { row + count, col })
end
-- map with count support: use <cmd>lua ... <CR> to get v:count1
map("n", "]<leader>", function() insert_lines_below(vim.v.count1) end, opts)
map("n", "[<leader>", function() insert_lines_above(vim.v.count1) end, opts)
