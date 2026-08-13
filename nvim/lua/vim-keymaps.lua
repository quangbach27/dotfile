local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Buffer navigate
vim.keymap.set("n", "H", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "L", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-w>", "<Cmd>bdelete<CR>", { desc = "Close buffer" })

-- Navigate vim panes better
keymap.set("n", "<c-k>", ":wincmd k<CR>")
keymap.set("n", "<c-j>", ":wincmd j<CR>")
keymap.set("n", "<c-h>", ":wincmd h<CR>")
keymap.set("n", "<c-l>", ":wincmd l<CR>")

keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Buffer-local keymaps, only set once an LSP actually attaches
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
		-- go back to where you were before jumping to a definition
		vim.keymap.set("n", "<leader>gb", "<C-t>", opts)
		vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
	end,
})

vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float({ scope = "line", focusable = false })
end, { desc = "Show line diagnostics" })
