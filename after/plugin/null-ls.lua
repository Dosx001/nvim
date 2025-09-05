local null_ls = require("null-ls")
local actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
null_ls.setup({
  sources = {
    -- actions.shellcheck,
    actions.gitsigns,
    -- actions.ltrs,
    diagnostics.buf,
    -- diagnostics.ltrs,
    diagnostics.cmake_lint,
    diagnostics.cppcheck.with({
      temp_dir = "/tmp",
      args = { "--check-level=exhaustive" },
    }),
    diagnostics.tidy,
    diagnostics.vint,
    diagnostics.pylint,
    require("none-ls.diagnostics.flake8"),
    -- diagnostics.shellcheck,
    diagnostics.markdownlint,
    diagnostics.selene,
    formatting.buf,
    formatting.cmake_format,
    formatting.stylua,
    formatting.black,
    formatting.isort,
    formatting.prettier,
    formatting.shfmt,
    require("none-ls.formatting.rustfmt"),
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})
