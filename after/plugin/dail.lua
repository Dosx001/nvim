local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.hex,
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%m/%d/%Y"],
    augend.constant.alias.bool,
    augend.constant.new({
      elements = { "True", "False" },
    }),
    augend.constant.new({
      elements = { "and", "or" },
    }),
    augend.constant.new({
      elements = { "&&", "||" },
      word = false,
    }),
    augend.constant.new({
      elements = { "==", "!=" },
      word = false,
    }),
    augend.constant.new({
      elements = { "<=", ">=" },
      word = false,
    }),
    augend.constant.new({
      elements = { "<", ">" },
      word = false,
    }),
  },
})
