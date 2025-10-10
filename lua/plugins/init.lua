return {
    "folke/todo-comments.nvim",
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },
    -- Mason for managing LSP servers
    {
        "williamboman/mason.nvim",
        config = true,
    },
    -- Setup LSP servers manually since mason-lspconfig has compatibility issues
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig").defaults() -- This will setup lua_ls
            
            -- Setup other servers you mentioned
            local lspconfig = require("lspconfig")
            local configs = require("configs.lspconfig")
            
            -- Setup pyright for Python
            lspconfig.pyright.setup {
                on_attach = configs.on_attach,
                capabilities = configs.capabilities,
                on_init = configs.on_init,
            }
            
            -- Setup clangd for C/C++
            lspconfig.clangd.setup {
                on_attach = configs.on_attach,
                capabilities = configs.capabilities,
                on_init = configs.on_init,
            }
        end,
    },
    -- LSP configuration 
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "python",
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        opts = function()
            local cmp = require("cmp")
            local conf = require("nvchad.configs.cmp")

            local mymappings = {
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<Tab>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
            }
            conf.mapping = vim.tbl_deep_extend("force", conf.mapping, mymappings)
            return conf
        end,
    },
}