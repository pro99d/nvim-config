return {
    "folke/todo-comments.nvim",
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require "configs.conform",
    },
    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "configs.lspconfig"
        end,
    },

    -- test new blink

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
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            servers = {
                -- pyright will be automatically installed with mason and loaded with lspconfig
                pyright = { venvPath = "./.venv/bin/" },
            },
        },

        -- add tsserver and setup with typescript.nvim instead of lspconfig
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                "jose-elias-alvarez/typescript.nvim",
                -- init = function()
                --   require("lazyvim.util").lsp.on_attach(function(_, buffer)
                --   -- stylua: ignore
                --   vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
                --     vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
                --   end)
                -- end,
            },
            ---@class PluginLspOpts
            opts = {
                ---@type lspconfig.options
                servers = {
                    -- tsserver will be automatically installed with mason and loaded with lspconfig
                    tsserver = {},
                },
                -- you can do any additional lsp server setup here
                -- return true if you don't want this server to be setup with lspconfig
                ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
                setup = {
                    -- example to setup with typescript.nvim
                    tsserver = function(_, opts)
                        require("typescript").setup { server = opts }
                        return true
                    end,
                    -- Specify * to use this function as a fallback for any server
                    -- ["*"] = function(server, opts) end,
                },
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
