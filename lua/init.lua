local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- My Suff
	"Dosx001/statusline.vim",
	"Dosx001/tabline.vim",
	"Dosx001/vim-template",
	-- Vim
	"christoomey/vim-sort-motion",
	"christoomey/vim-system-copy",
	"christoomey/vim-titlecase",
	"tommcdo/vim-exchange",
	"tpope/vim-fugitive",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"justinmk/vim-sneak",
	{
		"mattn/emmet-vim",
		event = "BufEnter",
		cond = function()
			return vim.bo.filetype == "hmtl" or vim.bo.filetype == "typescriptreact"
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		event = "BufEnter",
		cond = function()
			return vim.bo.filetype == "markdown"
		end,
	},
	{
		"kana/vim-textobj-user",
		dependencies = {
			"D4KU/vim-textobj-chainmember",
			"glts/vim-textobj-comment",
			"kana/vim-textobj-indent",
		},
	},
	-- Nvim
	"lukas-reineke/indent-blankline.nvim",
	"lewis6991/gitsigns.nvim",
	"monaqa/dial.nvim",
	"NvChad/nvim-colorizer.lua",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"gennaro-tedesco/nvim-peekup",
	"stevearc/dressing.nvim",
	{ "numToStr/Comment.nvim", config = true },
	{
		"glacambre/firenvim",
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		priority = 1,
		dependencies = {
			"weilbith/nvim-code-action-menu",
			"jose-elias-alvarez/null-ls.nvim",
			"mrshmllow/document-color.nvim",
			{
				"jose-elias-alvarez/typescript.nvim",
				event = "BufEnter",
				cond = function()
					return vim.bo.filetype == "typescriptreact"
				end,
				config = true,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"p00f/nvim-ts-rainbow",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"rcarriga/cmp-dap",
			"uga-rosa/cmp-dictionary",
			"saadparwaiz1/cmp_luasnip",
			"roobert/tailwindcss-colorizer-cmp.nvim",
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			{
				"mfussenegger/nvim-dap-python",
				dependencies = {
					"anuvyklack/hydra.nvim",
				},
				event = "BufEnter",
				cond = function()
					return vim.bo.filetype == "python"
				end,
				config = function()
					require("dap-python").setup()
					require("py-hydra")
				end,
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-treesitter/playground", cond = false },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
})
