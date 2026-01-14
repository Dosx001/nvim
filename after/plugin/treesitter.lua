local ts = require("nvim-treesitter")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang then
      return
    end
    if lang == "dockerfile" then
      vim.treesitter.stop(args.buf)
      return
    end
    if not vim.treesitter.language.add(lang) and vim.tbl_contains(ts.get_available(), lang) then
      ts.install(lang)
    end
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start(args.buf, lang)
    end
  end,
})

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
    include_surrounding_whitespace = false,
  },
})

local ts_select = require("nvim-treesitter-textobjects.select")
vim.keymap.set({ "x", "o" }, "af", function()
  ts_select.select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
  ts_select.select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aC", function()
  ts_select.select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "iC", function()
  ts_select.select_textobject("@class.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aa", function()
  ts_select.select_textobject("@parameter.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ia", function()
  ts_select.select_textobject("@parameter.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "al", function()
  ts_select.select_textobject("@loop.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "il", function()
  ts_select.select_textobject("@loop.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "aA", function()
  ts_select.select_textobject("@conditional.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "iA", function()
  ts_select.select_textobject("@conditional.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ar", function()
  ts_select.select_textobject("@return.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ir", function()
  ts_select.select_textobject("@return.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ae", function()
  ts_select.select_textobject("@assignment.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ie", function()
  ts_select.select_textobject("@assignment.inner", "textobjects")
end)

require("treesitter-modules").setup({
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-,>",
      scope_incremental = "<C-.>",
      node_incremental = "<A-.>",
      node_decremental = "<A-,>",
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
