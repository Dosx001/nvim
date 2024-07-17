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

local function text_request()
  return vim.api.nvim_eval("b:_codeium_completions.items[b:_codeium_completions.index].completionParts[0].text")
end

vim.keymap.set("i", "<M-w>", function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local text = string.match(text_request(), "[ ,;.]*[^ ,;.]+")
  vim.defer_fn(function()
    if string.match(text, "^\t") then
      vim.api.nvim_buf_set_lines(0, cursor[1], cursor[1], true, { text })
      vim.api.nvim_win_set_cursor(0, { cursor[1] + 1, #text })
    else
      vim.api.nvim_set_current_line(line:sub(0, cursor[2]) .. text .. line:sub(cursor[2] + 1))
      vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + #text })
    end
  end, 0)
end, { expr = true })

vim.keymap.set("i", "<M-o>", function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local text = string.gsub(text_request(), "\n.*$", "")
  if text ~= "" then
    vim.defer_fn(function()
      vim.api.nvim_set_current_line(line:sub(0, cursor[2]) .. text .. line:sub(cursor[2] + 1))
      vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + #text })
    end, 0)
  end
end, { expr = true })
