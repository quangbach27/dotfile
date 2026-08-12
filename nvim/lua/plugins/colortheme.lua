return {
	{
		"Mofiqul/vscode.nvim",
		priority = 1000,
		config = function()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
				italic_inlayhints = true,
				underline_links = true,
				disable_nvimtree_bg = true,
				terminal_colors = true,
				group_overrides = {
					-- completion menu background
					Pmenu = { bg = "#252526", fg = "#cccccc" },
					PmenuSel = { bg = "#04395e", fg = "#ffffff" },
					PmenuSbar = { bg = "#252526" },
					PmenuThumb = { bg = "#454545" },

					-- if using bordered nvim-cmp windows
					CmpBorder = { fg = "#454545" },
					CmpDocBorder = { fg = "#454545" },
				},
			})

			vim.o.termguicolors = true
			vim.o.background = "dark"
			vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "vscode",
				},
				sections = {
					lualine_a = {
						{
							"filename",
							path = 1,
						},
					},
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
					separator_style = "thin",
					always_show_bufferline = true,
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
							separator = true,
						},
					},
				},
			})

			vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = "#f14c4c" })
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#1e1e1e",
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "┊" },
		},
	},
}
