return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
            require("nvim-treesitter").install({
                "bash", "c", "cmake", "comment", "cpp", "dockerfile", "json",
                "lua", "make", "markdown", "meson", "python", "vim", "vimdoc",
            })

            -- Highlighting is a Neovim core feature. Start it only when a
            -- parser for the current buffer's filetype is available.
            local group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                callback = function(event)
                    pcall(vim.treesitter.start, event.buf)
                end,
            })
        end,
    },
}
