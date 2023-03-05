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
	-- "Dosx001/vim-lazy",
	"Dosx001/vim-template",
	-- Vim
	"christoomey/vim-sort-motion",
	"christoomey/vim-system-copy",
	"christoomey/vim-titlecase",
	"iamcco/markdown-preview.nvim", -- { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
	"mattn/emmet-vim",
	"tommcdo/vim-exchange",
	"tpope/vim-fugitive",
	"tpope/vim-repeat",
	"tpope/vim-surround",
	"justinmk/vim-sneak",
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
	{
		"glacambre/firenvim",
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
	"monaqa/dial.nvim",
	"numToStr/Comment.nvim",
	"anuvyklack/hydra.nvim",
	"NvChad/nvim-colorizer.lua",
	"L3MON4D3/LuaSnip",
	"rafamadriz/friendly-snippets",
	"gennaro-tedesco/nvim-peekup",
	"stevearc/dressing.nvim",
	{
		"neovim/nvim-lspconfig",
		build = ":TSUpdate",
		dependencies = {
			"weilbith/nvim-code-action-menu",
			"jose-elias-alvarez/null-ls.nvim",
			"mrshmllow/document-color.nvim",
			"jose-elias-alvarez/typescript.nvim",
			-- "ray-x/lsp_signature.nvim",
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
		build = ":TSUpdate",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"rcarriga/cmp-dap",
			"uga-rosa/cmp-dictionary",
		},
	},
	{
		"mfussenegger/nvim-dap",
		build = ":TSUpdate",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"mfussenegger/nvim-dap-python",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		build = ":TSUpdate",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
})
