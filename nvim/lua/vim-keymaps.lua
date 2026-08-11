local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Buffer navigate
vim.keymap.set("n", "H", "<Cmd>bprevious<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "L", "<Cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-w>", "<Cmd>bdelete<CR>", { desc = "Close buffer" })

-- Navigate vim panes better
keymap.set('n', '<c-k>', ':wincmd k<CR>')
keymap.set('n', '<c-j>', ':wincmd j<CR>')
keymap.set('n', '<c-h>', ':wincmd h<CR>')
keymap.set('n', '<c-l>', ':wincmd l<CR>')

keymap.set('n', '<leader>h', ':nohlsearch<CR>')

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
