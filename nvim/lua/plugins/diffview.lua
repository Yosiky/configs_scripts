return {

    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open working-tree diff" },
            { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
            { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
        },
    },

    -- {
    --  "NeogitOrg/neogit",
    --  dependencies = {
    --      "nvim-lua/plenary.nvim",         -- required
    --      "sindrets/diffview.nvim",        -- optional - Diff integration
    --  },
    --  config = true
    -- }



}
