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
		opts = function(_, opts)
			opts.routes = opts.routes or {}
			opts.presets = opts.presets or {}

			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})

			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true

			return opts
		end,
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},
}
