return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		vim.keymap.set(
			"n",
			"<C-n>",
			":Neotree toggle reveal left<CR>",
			{ noremap = true, silent = true, desc = "Toggle Neotree" }
		)
		vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
	end,
}
