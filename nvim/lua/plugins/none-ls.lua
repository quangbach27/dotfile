return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"goimports_reviser", -- maps to null-ls source below
				"golangci_lint",
				"prettier",
				"stylelint",
			},
			automatic_installation = true,
		})
		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Go
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports_reviser,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.diagnostics.golangci_lint,

				-- JS / TS / React (jsx, tsx) / CSS / HTML / JSON / Markdown
				null_ls.builtins.formatting.prettier.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"css",
						"scss",
						"less",
						"html",
						"json",
						"yaml",
						"markdown",
					},
				}),

				-- CSS/Tailwind linting (optional, needs stylelint + config in project)
				null_ls.builtins.diagnostics.stylelint,

				-- terraform
				null_ls.builtins.formatting.packer,
				null_ls.builtins.formatting.terraform_fmt,
				null_ls.builtins.diagnostics.terraform_validate,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
