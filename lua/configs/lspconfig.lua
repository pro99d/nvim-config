require("nvchad.configs.lspconfig").defaults()
local servers = { "html", "cssls", "pyright", "lua_ls", "clangd" }
vim.lsp.enable(servers)
vim.lsp.start(servers)
local lspconfig = require("lspconfig")
local mason_registry = require("mason-registry")
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
    vim.notify("mason-lspconfig not found", vim.log.levels.WARN)
    return
end

-- ensure mason-lspconfig is set to manage lspconfig servers
mason_lspconfig.setup({
    ensure_installed = servers, -- add servers you want installed, e.g., "pyright"
    automatic_installation = false,
})

-- utility: register mason-installed servers with lspconfig
local function setup_mason_servers()
    local handlers = {}
    -- default handler
    handlers["*"] = function(server_name)
        local ok, server = pcall(require, "lspconfig.server_configurations." .. server_name)
        if not ok then return end
        lspconfig[server_name].setup({})
    end

    -- override per-server options here, if needed:
    handlers["pyright"] = function()
        lspconfig.pyright.setup({})
    end

    mason_lspconfig.setup_handlers(handlers)
end

setup_mason_servers()

-- read :h vim.lsp.config for changing options of lsp servers
