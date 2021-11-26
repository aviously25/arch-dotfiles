vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("shaunsingh/nord.nvim")

	-- LSP and Formatter stuff
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin
	use("mhartington/formatter.nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Which Key
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				spelling = { enabled = true },
			})
		end,
	})

	-- Auto Pairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	-- TreeSitter
	use({
		"nvim-treesitter/nvim-treesitter",
		branch = "0.5-compat",
		run = ":TSUpdate",
	})

	-- Lualine and Barline/Tabline
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- NvimTree
	use({
		"kyazdani42/nvim-tree.lua",
	})

	-- Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Debugging
	use({
		"mfussenegger/nvim-dap",
	})

	-- Debugger management
	use({
		"Pocco81/DAPInstall.nvim",
	})

	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				open_mapping = "<c-t>",
				direction = "float",
				float_opts = {
					border = "curved",
				},
			})
		end,
	})
end)
