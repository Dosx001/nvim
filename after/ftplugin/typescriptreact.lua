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
    -- format_item = function(item) return "I like to visit " .. item end,
  }, function(_, idx)
    if idx == 1 then
      vim.cmd("TypescriptAddMissingImports")
    elseif idx == 2 then
      vim.cmd("TypescriptOrganizeImports")
    elseif idx == 3 then
      vim.cmd("TypescriptRenameFile")
    elseif idx == 4 then
      vim.cmd("TypescriptRemoveUnused")
    elseif idx == 5 then
      vim.cmd("TypescriptGoToSourceDefinition")
    elseif idx == 6 then
      vim.cmd("TypescriptFixAll")
    end
  end)
end, {})
