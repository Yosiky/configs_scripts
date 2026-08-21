return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = false,
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.nav_hunk("next")
                    end
                end, "Next Git hunk")
                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.nav_hunk("prev")
                    end
                end, "Previous Git hunk")

                map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
                map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Stage selected lines")
                map("v", "<leader>hr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, "Reset selected lines")
                map("n", "<leader>hd", gitsigns.diffthis, "Diff current file")
                map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
                map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview hunk inline")
                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end, "Blame current line")
                map("n", "<leader>hB", gitsigns.blame, "Blame current file")
                map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Toggle line blame")
                map("n", "<leader>tw", gitsigns.toggle_word_diff, "Toggle word diff")
            end,
        },
    },
}
