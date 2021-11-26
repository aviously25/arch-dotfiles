local opts = { noremap = true }

vim.api.nvim_set_keymap("i", "jk", "<Esc>", opts)
vim.api.nvim_set_keymap("n", "K", ":BufferNext<CR>", opts)
vim.api.nvim_set_keymap("n", "J", ":BufferPrevious<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)

-- Auto format on save
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.c++,*.c,*.js,*.rs,*.lua FormatWrite
augroup END
]],
	true
)

-- enable spell check on .md and .txt files
vim.api.nvim_exec(
	[[
    autocmd BufRead,BufNewFile *.md,*.txt setlocal spell
  ]],
	true
)
