return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				window = {
					position = "left",
					width = 36,
				},
				filesystem = {
					follow_current_file = {
						enabled = true,
						leave_dirs_open = false,
					},
					use_libuv_file_watcher = true,
					filtered_items = {
						never_show = { ".DS_Store" },
					},
				},
			})

			vim.keymap.set('n', '<C-n>', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle file tree' })
			vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle file tree' })
			vim.keymap.set('n', '<leader>er', '<Cmd>Neotree reveal<CR>', { desc = 'Reveal current file in tree' })
		end
	}
}
