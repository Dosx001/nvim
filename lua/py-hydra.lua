local Hydra = require("hydra")
local dap, dapui = require("dap"), require("dapui")

local dap_hydra = Hydra({
  name = "DAP",
  mode = { "n", "x" },
  body = "<Leader>d",
  heads = {
    -- 	-- 	dap.set_breakpoint(vim.fn.input("[Condition] > "))
    -- 	-- 	return "<Ignore>"
    -- 	-- "c",
    -- 	-- end,
    -- 	-- function()
    -- 	-- { expr = true },
    -- {
    -- { "i", dap.step_into, { silent = true } },
    -- { "o", dap.step_out, { silent = true } },
    -- { "p", dap.pause, { silent = true } },
    -- { "s", dap.step_over, { silent = true } },
    -- { "t", dap.terminate, { silent = true } },
    -- },
    { "<Enter>", dap.session, { silent = true } },
    { "<Esc>", nil, { exit = true, nowait = true } },
    { "B", dap.toggle_breakpoint, { silent = true } },
    { "C", dap.clear_breakpoints, { silent = true } },
    { "J", dap.down, { silent = true } },
    { "K", dap.up, { silent = true } },
    { "R", dap.run_last, { silent = true } },
    { "b", dap.set_breakpoint, { silent = true } },
    { "j", "j" },
    { "k", "k" },
    { "r", dap.run_to_cursor, { silent = true } },
    { "u", dapui.toggle, { silent = true } },
  },
})

Hydra.spawn = function(head)
  if head == "dap-hydra" then
    dap_hydra:activate()
  end
end
