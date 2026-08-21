return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = "FormatToggle",
        opts = {
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
                python = { "isort", "black" },
                sh = { "shfmt" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
            },
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 3000, lsp_format = "fallback" }
            end,
        },
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                desc = "Format buffer",
            },
            {
                "<leader>cF",
                function()
                    vim.b.disable_autoformat = not vim.b.disable_autoformat
                    local state = vim.b.disable_autoformat and "disabled" or "enabled"
                    vim.notify("Format on save " .. state .. " for this buffer")
                end,
                desc = "Toggle format on save (buffer)",
            },
        },
        config = function(_, opts)
            if vim.g.disable_autoformat == nil then
                vim.g.disable_autoformat = true
            end

            require("conform").setup(opts)

            vim.api.nvim_create_user_command("FormatToggle", function(args)
                if args.bang then
                    vim.b.disable_autoformat = not vim.b.disable_autoformat
                    local state = vim.b.disable_autoformat and "disabled" or "enabled"
                    vim.notify("Format on save " .. state .. " for this buffer")
                    return
                end

                vim.g.disable_autoformat = not vim.g.disable_autoformat
                local state = vim.g.disable_autoformat and "disabled" or "enabled"
                vim.notify("Format on save " .. state .. " globally")
            end, {
                bang = true,
                desc = "Toggle format on save (! for current buffer)",
            })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            {
                "<leader>cL",
                function()
                    require("lint").try_lint()
                end,
                desc = "Lint buffer",
            },
        },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                sh = { "shellcheck" }, bash = { "shellcheck" }, zsh = { "shellcheck" },
            }
            local group = vim.api.nvim_create_augroup("UserLint", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePost", {
                group = group,
                callback = function() lint.try_lint() end,
            })
        end,
    },
}
