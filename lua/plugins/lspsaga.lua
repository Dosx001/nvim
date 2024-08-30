return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    vim.keymap.set({ "n", "t" }, "<A-\\>", "<cmd>Lspsaga term_toggle<CR>")
    require("lspsaga").setup({
      code_action = {
        show_server_name = true,
        extents_gitsigns = true,
        keys = {
          quit = "<Esc>",
        },
      },
      lightbulb = {
        enable = false,
      },
      symbol_in_winbar = {
        enable = false,
      },
      outline = {
        auto_preview = false,
        win_position = "left",
      },
    })
  end,
}
