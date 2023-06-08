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
		"Exafunction/codeium.vim",
		config = function()
			vim.g.codeium_disable_bindings = 1
			vim.keymap.set("i", "<M-p>", function()
				return vim.fn["codeium#Accept"]()
			end, { expr = true })
			vim.keymap.set("i", "<M-x>", function()
				return vim.fn["codeium#Clear"]()
			end, { expr = true })
			vim.keymap.set("i", "<M-]>", function()
				return vim.fn["codeium#CycleCompletions"](1)
			end, { expr = true })
			vim.keymap.set("i", "<M-[>", function()
				return vim.fn["codeium#CycleCompletions"](-1)
			end, { expr = true })
		end,
	},
	{
		"mattn/emmet-vim",
		event = "BufEnter",
		cond = function()
			return vim.bo.filetype == "html" or vim.bo.filetype == "typescriptreact"
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
	"nvim-tree/nvim-web-devicons",
	{ "stevearc/oil.nvim", config = true },
	{
		"akinsho/toggleterm.nvim",
		config = true,
		event = "VeryLazy",
		opts = {
			open_mapping = [[<A-\>]],
			direction = "float",
		},
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"glacambre/firenvim",
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = { "firenvim" }, wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = false,
				},
				symbol_in_winbar = {
					enable = false,
				},
				outline = {
					win_position = "left",
				},
			})
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
					return vim.bo.filetype == "typescript" or vim.bo.filetype == "typescriptreact"
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
			"mrjones2014/nvim-ts-rainbow",
			"JoosepAlviste/nvim-ts-context-commentstring",
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
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
})
