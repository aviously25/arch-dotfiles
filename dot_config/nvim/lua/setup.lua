------------------------- TELESCOPE SEtUP -------------------
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

------------------------- SETUP LSP INSTALLER---------------------------------
local lsp_installer = require("nvim-lsp-installer")

-- Use an on_attach function to only map the following keys after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	-- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	-- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

lsp_installer.on_server_ready(function(server)
	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end

	-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
	local serverOps = { on_attach = on_attach, flags = { debounce_text_changes = 150 } }
	server:setup(serverOps)
	vim.cmd([[ do User LspAttachBuffers ]])
end)

-- ----------NVIM CMP FOR LSP SETUP-----------------------------
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		--['<Tab>'] = function(fallback)
		--  if cmp.visible() then
		--    cmp.select_next_item()
		--  elseif luasnip.expand_or_jumpable() then
		--    luasnip.expand_or_jump()
		--  else
		--    fallback()
		--  end
		--end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
})

-- Auto Pairs
-- you need setup cmp first put this after cmp.setup()
require("cmp").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
	auto_select = true, -- automatically select the first item
	insert = false, -- use insert confirm behavior instead of replace
	map_char = { -- modifies the function or method delimiter by filetypes
		all = "(",
		tex = "{",
	},
})

------------------- FORMATTERS ----------------------
require("formatter").setup({
	filetype = {
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"--config-path " .. os.getenv("XDG_CONFIG_HOME") .. "/stylua/stylua.toml",
						"-",
					},
					stdin = true,
				}
			end,
		},
		cpp = {
			-- clang-format
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
		c = {
			-- clang-format
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
		javascript = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
					stdin = true,
				}
			end,
		},
		json = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
					stdin = true,
				}
			end,
		},
	},
})

-------------------- WHICH KEY SETUP --------------------------
local wk = require("which-key")
wk.register({
	-- LSP Keybindings
	l = {
		name = "LSP Servers",
		-- f = { "zA", "Toggle Fold" },
		f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format File" },
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

-------------------- TREESITTER SETUP ----------------------
require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		-- disable = { "c", "rust" }, -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 99

--------------------- LUA LINE SETUP ----------------------
local options = {
	theme = "nord",
}
require("lualine").setup({ options = options })

---------------------- NVIM TREE -------------------------
-- show lsp diagnostics in the signcolumn
require("nvim-tree").setup({
	open_on_setup = true,
	auto_close = true,
	open_on_tab = true,
	-- show lsp diagnostics in the signcolumn
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		width = 20,
		auto_resize = true,
	},
})
