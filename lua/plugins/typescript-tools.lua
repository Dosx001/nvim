return {
  "pmizio/typescript-tools.nvim",
  ft = { "typescript", "typescriptreact" },
  config = function()
    require("typescript-tools").setup({
      on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          importModuleSpecifierPreference = "non-relative",
        },
      },
    })
  end,
  vim.keymap.set("n", "<A-t>", function()
    vim.ui.select({
      "Add Missing Imports",
      "Organize Imports",
      "Rename File",
      "Remove Unused",
      "Go To Source Definition",
      "Fix All",
    }, {
      prompt = "Select Action",
    }, function(_, idx)
      if idx == 1 then
        vim.cmd("TSToolsAddMissingImports")
      elseif idx == 2 then
        vim.cmd("TSToolsOrganizeImports")
      elseif idx == 3 then
        vim.cmd("TSToolsRenameFile")
      elseif idx == 4 then
        vim.cmd("TSToolsRemoveUnused")
      elseif idx == 5 then
        vim.cmd("TSToolsGoToSourceDefinition")
      elseif idx == 6 then
        vim.cmd("TSToolsFixAll")
      end
    end)
  end, {}),
}
