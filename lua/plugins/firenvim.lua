return {
  "glacambre/firenvim",
  lazy = not vim.g.started_by_firenvim,
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  config = function()
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = "github.com_*.txt",
      cmd = "set filetype=markdown",
    })
    vim.g.firenvim_config = {
      localSettings = {},
    }
  end,
}
