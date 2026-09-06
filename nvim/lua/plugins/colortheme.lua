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

			local max_buffers = 6
			local group = vim.api.nvim_create_augroup("BufferlineMaxBuffers", { clear = true })

			vim.api.nvim_create_autocmd("BufEnter", {
				group = group,
				callback = function(args)
					vim.b[args.buf].bufline_last_used = vim.uv.hrtime()
				end,
			})

			local function has_pending_lsp_request(bufnr)
				for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
					for _, req in pairs(client.requests) do
						if req.bufnr == bufnr then
							return true
						end
					end
				end
				return false
			end

			vim.api.nvim_create_autocmd("BufAdd", {
				group = group,
				callback = function()
					local listed = vim.tbl_filter(function(bufnr)
						return vim.bo[bufnr].buflisted
					end, vim.api.nvim_list_bufs())

					if #listed <= max_buffers then
						return
					end

					local current = vim.api.nvim_get_current_buf()
					local candidates = vim.tbl_filter(function(bufnr)
						return bufnr ~= current and vim.fn.bufwinid(bufnr) == -1
					end, listed)

					table.sort(candidates, function(a, b)
						return (vim.b[a].bufline_last_used or 0) < (vim.b[b].bufline_last_used or 0)
					end)

					for _, bufnr in ipairs(candidates) do
						if not vim.bo[bufnr].modified and not has_pending_lsp_request(bufnr) then
							pcall(vim.cmd, "bdelete " .. bufnr)
							break
						end
					end
				end,
			})
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
