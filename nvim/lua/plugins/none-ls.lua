return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Ruby
				null_ls.builtins.diagnostics.erb_lint,
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.formatting.rubocop,

				-- Go
				null_ls.builtins.formatting.gofmt,
				null_ls.builtins.formatting.goimports,
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
        null_ls.builtins.diagnostics.eslint_d,

				-- CSS/Tailwind linting (optional, needs stylelint + config in project)
				null_ls.builtins.diagnostics.stylelint,
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
