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
						},
					},
				},
			},
		},
		config = function(_, opts)
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "gopls" },
			})

			for server, config in pairs(opts.servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
}
