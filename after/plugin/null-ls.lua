local null_ls = require("null-ls")
local actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
null_ls.setup({
	sources = {
		actions.eslint_d,
		actions.shellcheck,
		actions.gitsigns,
		actions.ltrs,
		-- actions.proselint,
		diagnostics.ltrs,
		diagnostics.cppcheck,
		diagnostics.tidy,
		-- diagnostics.stylelint,
		diagnostics.pylint,
		diagnostics.flake8,
		diagnostics.eslint_d,
		diagnostics.shellcheck,
		diagnostics.markdownlint,
		diagnostics.selene,
		-- diagnostics.proselint,
		formatting.stylua,
		formatting.black,
		formatting.isort,
		formatting.prettier,
		formatting.shfmt,
		formatting.rustfmt,
	},
})
