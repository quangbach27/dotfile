return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- Per-server settings must be configured BEFORE mason-lspconfig
			-- enables them, since automatic_enable calls vim.lsp.enable()
			-- as soon as install finishes.

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls", -- TypeScript/JavaScript, also handles React (.tsx/.jsx)
					"gopls", -- Go
					"rust_analyzer", -- Rust
					"lua_ls", -- Lua
					"html",
					"cssls",
					"emmet_ls", -- HTML/JSX abbreviation expansion
					"tailwindcss",
				},
			})

			-- Buffer-local keymaps, only set once an LSP actually attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
}
