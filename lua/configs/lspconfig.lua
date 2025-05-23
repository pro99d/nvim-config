require("nvchad.configs.lspconfig").defaults()
local servers = { "html", "cssls" , "pyright", "lua_ls", "clangd"}
vim.lsp.enable(servers)
vim.lsp.start(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
