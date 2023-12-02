vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#b30000" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#ca5900" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#bcbc00" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#00b300" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56c5f0" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "Blue" })
vim.api.nvim_set_hl(0, "RainbowMagenta", { fg = "#b300b3" })

vim.g.rainbow_delimiters = {
  highlight = {
    "RainbowRed",
    "RainbowOrange",
    "RainbowYellow",
    "RainbowGreen",
    "RainbowCyan",
    "RainbowBlue",
    "RainbowMagenta",
  },
}
