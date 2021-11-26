local wk = require("which-key")
wk.register({
	-- LSP Keybindings
	l = {
		name = "LSP Servers",
		f = { "zA", "Toggle Fold" },
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
		d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to Declaration" },
		i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol" },
		R = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
		e = { "<cmd>lua vim.lsp.buf.show_line_diagnostics()<CR>", "Show Line Diagnostics" },
	},
	-- Telescope/file keybindings
	f = {
		name = "file",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		t = { "<cmd>:NvimTreeToggle<CR>", "Toggle NvimTree" },
		c = { "<cmd>:BufferClose<CR>", "Close buffer" },
	},
	["/"] = { "<cmd> lua require('Comment').toggle()<CR>", "Comment current line" },
}, {
	prefix = "<leader>",
})

-- Visual Mode Bindings
wk.register({
	["/"] = { "gc", "Comment region", noremap = false },
}, {
	prefix = "<leader>",
	mode = "v",
})
