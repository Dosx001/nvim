local dap, dapui = require("dap"), require("dapui")

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 0.3,
      position = "right",
    },
    {
      elements = {
        "console",
        "repl",
      },
      size = 0.25,
      position = "bottom",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

local function getBinary()
  local cwd = vim.fn.getcwd()
  local name = vim.fn.fnamemodify(cwd, ":t")
  if vim.fn.isdirectory(cwd .. "/zig-out") == 1 then
    return cwd .. "/zig-out/bin/" .. name
  elseif vim.fn.isdirectory(cwd .. "/build/debug") == 1 then
    return cwd .. "/build/debug/" .. name
  elseif vim.fn.isdirectory(cwd .. "/target") == 1 then
    return cwd .. "/target/debug/" .. name
  end
  return vim.fn.input("Path to executable: ", cwd .. "/", "file")
end

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = getBinary,
    args = function()
      return vim.fn.input({ prompt = "Arguments: " })
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = getBinary,
    pid = function()
      local name = vim.fn.input("Executable name (filter): ")
      return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Attach to gdbserver :1234",
    type = "gdb",
    request = "attach",
    target = "localhost:1234",
    program = getBinary,
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c
dap.configurations.zig = dap.configurations.c

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return "/usr/bin/python"
      end
    end,
  },
}

vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F6>", dap.restart)
vim.keymap.set("n", "<F7>", dap.pause)
vim.keymap.set("n", "<F8>", dap.terminate)

vim.keymap.set("n", "<leader>dl", dap.goto_)
vim.keymap.set("n", "<leader>do", dapui.toggle)
vim.keymap.set("n", "<leader>dr", dap.run_to_cursor)
vim.keymap.set("n", "<leader>dR", dap.run_last)
vim.keymap.set("n", "<leader>dc", function()
  vim.keymap.setap.set_breakpoint(vim.fn.input("Condition: "))
end)

local widgets = require("dap.ui.widgets")
vim.keymap.set("n", "<leader>dh", widgets.hover)
vim.keymap.set("n", "<leader>ds", function()
  widgets.centered_float(widgets.scopes)
end)

local dap_python = require("dap-python")
vim.keymap.set("n", "<leader>dpc", dap_python.test_class)
vim.keymap.set("n", "<leader>dpm", dap_python.test_method)
vim.keymap.set("n", "<leader>dps", dap_python.debug_selection)
