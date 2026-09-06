return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local languages = {
			"rust",
			"javascript",
			"lua",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"typescript",
			"markdown",
			"markdown_inline",
			"terraform",
			"hcl",
			"rust",
			"sql",
			"toml",
		}

		require("nvim-treesitter").install(languages)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
