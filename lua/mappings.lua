require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local options = {noremap=true, silent=true}
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<ESC>", "<C-\\><C-n>", options)
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", options)
map({'n','v'}, "\\", "<cmd> NvimTreeToggle<CR>", options)
map({"n", "t", "v"}, "<C-left>", "<C-w>>")
map({"n", "t", "v"}, "<C-up>", "<C-w>+")
map({"n", "t", "v"}, "<C-right>", "<C-w><")
map({"n", "t", "v"}, "<C-down>", "<C-w>-")
map("i", "<C-left>", "<ESC>bi", options)
map("i", "<C-right>", "<ESC>wi", options)
map("i", "<C-BS>", "<ESC>dbi")
map("i", "<C-DEL>", "<ESC>dwi")
-- map("n", "<C")

