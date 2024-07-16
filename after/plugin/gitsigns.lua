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
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
  end,
})
