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
