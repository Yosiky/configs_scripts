return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "mason-org/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
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
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.diagnostic.config({
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                signs = true,
                underline = true,
                virtual_text = { spacing = 2 },
            })

            vim.lsp.config("clangd", {
                capabilities = capabilities,
                cmd = { "clangd", "--background-index" },
                offset_encoding = "utf-16",
            })
            vim.lsp.config("cmake", {
                capabilities = capabilities,
                init_options = { buildDirectory = "build" },
            })
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("bashls", { capabilities = capabilities })
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = { Lua = { diagnostics = { globals = { "vim" } } } },
            })
            -- Ruff supplies Python diagnostics and code actions; Pyright keeps navigation.
            vim.lsp.config("ruff", {
                capabilities = capabilities,
                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                end,
            })

            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "cmake", "pyright", "bashls", "lua_ls", "ruff" },
            })
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "clang-format", "black", "isort", "shfmt",
                    "shellcheck"
                },
            })

            local group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = group,
                callback = function(event)
                    local opts = { buffer = event.buf, silent = true }
                    vim.keymap.set("n", "K", vim.lsp.buf.hover,
                        vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                        vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                        vim.tbl_extend("force", opts, { desc = "Go to definition" }))
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                        vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
                    vim.keymap.set("n", "gr", vim.lsp.buf.references,
                        vim.tbl_extend("force", opts, { desc = "Find references" }))
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
                        vim.tbl_extend("force", opts, { desc = "Code action" }))
                    -- <leader>rn remains the incremental rename provided by inc-rename.nvim.
                    vim.keymap.set("n", "<leader>rN", vim.lsp.buf.rename,
                        vim.tbl_extend("force", opts, { desc = "LSP rename" }))
                    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float,
                        vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
                end,
            })
        end
    },
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
            { "<leader>rn", ":IncRename " }
        }
    }
}
