local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "IndentBlanklineRed", { fg = "DarkRed" })
	vim.api.nvim_set_hl(0, "IndentBlanklineOrange", { fg = "#974300" })
	vim.api.nvim_set_hl(0, "IndentBlanklineYellow", { fg = "#828200" })
	vim.api.nvim_set_hl(0, "IndentBlanklineGreen", { fg = "DarkGreen" })
	vim.api.nvim_set_hl(0, "IndentBlanklineCyan", { fg = "DarkCyan" })
	vim.api.nvim_set_hl(0, "IndentBlanklineBlue", { fg = "DarkBlue" })
	vim.api.nvim_set_hl(0, "IndentBlanklineViolet", { fg = "DarkMagenta" })
end)

local highlight = {
	"IndentBlanklineRed",
	"IndentBlanklineOrange",
	"IndentBlanklineYellow",
	"IndentBlanklineGreen",
	"IndentBlanklineCyan",
	"IndentBlanklineBlue",
	"IndentBlanklineViolet",
}

require("ibl").setup({ indent = { highlight = highlight }, scope = { enabled = false } })
