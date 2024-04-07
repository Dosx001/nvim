local null_ls = require("null-ls")
local actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
null_ls.setup({
  sources = {
    require("none-ls.code_actions.eslint_d"),
    -- actions.shellcheck,
    actions.gitsigns,
    -- actions.ltrs,
    -- actions.proselint,
    diagnostics.ltrs,
    diagnostics.cmake_lint,
    diagnostics.cppcheck.with({
      temp_dir = "/tmp",
    }),
    diagnostics.tidy,
    diagnostics.vint,
    diagnostics.pylint,
    require("none-ls.diagnostics.flake8"),
    require("none-ls.diagnostics.eslint_d"),
    -- diagnostics.shellcheck,
    diagnostics.markdownlint,
    diagnostics.selene,
    formatting.cmake_format,
    formatting.stylua,
    formatting.black,
    formatting.isort,
    formatting.prettier,
    formatting.shfmt,
    require("none-ls.formatting.rustfmt"),
  },
})
