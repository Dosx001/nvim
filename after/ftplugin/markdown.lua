vim.keymap.set("n", "<C-m>", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr)
  local query = vim.treesitter.query.parse("markdown", "(pipe_table_row(pipe_table_cell)@cell)")
  local count = 0
  for _, node in query:iter_captures(parser:parse()[1]:root(), bufnr) do
    count = count + 1
    if count % 4 == 0 then
      local start_row, start_col, end_row, end_col = node:range()
      local str = vim.api.nvim_buf_get_text(bufnr, start_row, start_col, end_row, end_col, {})[1]
      local num = tonumber(string.gsub(str, "%s+", ""), 10)
      vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, { tostring(num + 1) })
    end
  end
end)
