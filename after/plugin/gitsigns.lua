require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "−" },
    topdelete = { text = "‾" },
    changedelete = { text = "~−" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "•" },
    change = { text = "•" },
    delete = { text = "•" },
    topdelete = { text = "•" },
    changedelete = { text = "•" },
    untracked = { text = "┆" },
  },
  on_attach = function(buf)
    vim.keymap.set({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buf })
    vim.keymap.set("n", "<A-[>", ":Gitsigns prev_hunk<CR>")
    vim.keymap.set("n", "<A-]>", ":Gitsigns next_hunk<CR>")
    vim.keymap.set("n", "<leader>gR", ":Gitsigns reset_buffer<CR>")
    vim.keymap.set("n", "<leader>gS", ":Gitsigns stage_buffer<CR>")
    vim.keymap.set("n", "<leader>gU", ":Gitsigns reset_buffer_index<CR>")
    vim.keymap.set("n", "<leader>gb", ":Gitsigns blame_line<CR>")
    vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
    vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>")
    vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>")
    vim.keymap.set("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>")
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#3cef3c", bg = "#242424" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#efef00", bg = "#242424" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#b30000", bg = "#242424" })
    vim.api.nvim_set_hl(0, "GitSignsChangeDelete", { fg = "#ef5900", bg = "#242424" })
    vim.api.nvim_set_hl(0, "GitSignsStagedAdd", { fg = "#3cef3c", bg = "#1a1a1a" })
    vim.api.nvim_set_hl(0, "GitSignsStagedChange", { fg = "#efef00", bg = "#1a1a1a" })
    vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { fg = "#b30000", bg = "#1a1a1a" })
    vim.api.nvim_set_hl(0, "GitSignsStagedChangedelete", { fg = "#b30000", bg = "#1a1a1a" })
    vim.api.nvim_set_hl(0, "GitSignsStagedTopdelete", { fg = "#b30000", bg = "#1a1a1a" })
  end,
})
