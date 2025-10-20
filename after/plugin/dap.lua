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
      size = 40,
      position = "left",
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
