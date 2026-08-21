return {
    {
        'nvim-telescope/telescope.nvim', tag = 'v0.2.1',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- NOTE: optinal, but recomendentb
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
        config = function()
            local telescope = require('telescope')
            local builtin = require('telescope.builtin')

            -- The native extension makes matching in large result sets faster.
            pcall(telescope.load_extension, 'fzf')

            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
            vim.keymap.set('n', '<leader>fG', builtin.live_grep, { desc = 'Search text in project' })
            vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Resume last picker' })
            vim.keymap.set('n', '<leader>fg', builtin.grep_string, { desc = 'Search word under cursor' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search Neovim help' })
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find recent files' })
            vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find diagnostics' })
            vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Find document symbols' })
        end
    },
}
