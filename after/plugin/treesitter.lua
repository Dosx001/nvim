require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
	highlight = {
		enable = true,
		disable = { "vim" },
		custom_captures = {
			-- ["<capture group>"] = "<hi group>",
			--["field"] = "TSComment",
			--["property"] = "TSComment",
			-- ["tag.attribute"] = "TSType",
			-- ["tag.delimiter"] = "TSParameter",
		},
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-,>",
			scope_incremental = "<C-.>",
			node_incremental = "<A-.>",
			node_decremental = "<A-,>",
		},
	},
	textobjects = {
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]l"] = "@loop.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]L"] = "@loop.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[l"] = "@loop.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[L"] = "@loop.outer",
			},
		},
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["aA"] = "@conditional.outer",
				["iA"] = "@conditional.inner",
				["ir"] = "@return.inner",
				["ar"] = "@return.outer",
				["ie"] = "@assignment.inner",
				["ae"] = "@assignment.outer",
			},
		},
	},
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 0,
	trim_scope = "outer",
	patterns = {
		default = {
			"class",
			"function",
			"method",
			"for",
			"while",
			"if",
			"switch",
			"case",
		},
	},
	zindex = 20,
	mode = "cursor",
})
