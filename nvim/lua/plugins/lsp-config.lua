return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				ts_ls = {},
				gopls = {
					settings = {
						gopls = {
							completeUnimported = true,
							-- usePlaceholders = true,
							analyses = {
								unusedparams = true,
								unusedwrite = true,
								shadow = true,
							},
							gofumpt = true,
							staticcheck = true,
							buildFlags = { "-tags=integration,component,testutils" },
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
							},
						},
					},
				},
				sqls = {},
				jdtls = {},
				terraformls = {},
			},
		},
		config = function(_, opts)
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(opts.servers),
				automatic_enable = { exclude = { "jdtls" } },
			})

			for server, config in pairs(opts.servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end

			-- Buffer-local keymaps, only set once an LSP actually attaches
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local o = { buffer = args.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, o)

					-- go back to where you were before jumping to a definition
					vim.keymap.set("n", "<leader>gb", "<C-t>", o)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, o)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o)
					vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, o)
				end,
			})

			-- Diagnostic config
			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float({ scope = "line", focusable = false })
			end, { desc = "Show line diagnostics" })

			vim.diagnostic.config({
				virtual_text = false,
				-- virtual_lines = true,
				underline = true,
			})
		end,
	},
}
