return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "clangd",
                    "cmake"
                    },
            }
        end
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "SmiteshP/nvim-navbuddy",
                dependencies = {
                    "SmiteshP/nvim-navic",
                    "MunifTanjim/nui.nvim"
                },
                opts = { lsp = { auto_attach = true } }
            }
        },
        config = function()
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set('n', '<leader>wl',
                function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
        end
    },

    -- {
    --     "Dan7h3x/signup.nvim",
    --     branch = "main",
    --     opts = {
    --         dock_mode = {enabled = true}
    --         -- Your configuration options here
    --     },
    --     config = function(_,opts)
    --         require("signup").setup(opts)
    --     end
    -- }
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
            handler_opts = { border = "rounded" },
            hint_prefix = "🦊 "
        }
    },

    {
        "smjonas/inc-rename.nvim",
        opts = {},
        keys = {
            {"<leader>rn", ":IncRename "}
        }
    }
}
