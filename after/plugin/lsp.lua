local function contain(tab, val)
  for _, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

local function disalbeFormatting(client)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
end

local border = {
  { "┌", "FloatBorder" },
  { "─", "FloatBorder" },
  { "┐", "FloatBorder" },
  { "│", "FloatBorder" },
  { "┘", "FloatBorder" },
  { "─", "FloatBorder" },
  { "└", "FloatBorder" },
  { "│", "FloatBorder" },
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.documentColor = {
  dynamicRegistration = true,
}

for _, lsp in pairs({
  "bashls",
  "clangd",
  "eslint",
  "html",
  "jsonls",
  "prismals",
  "pyright",
  "tailwindcss",
  "vimls",
  "zls",
}) do
  require("lspconfig")[lsp].setup({
    capabilities = capabilities,
    on_attach = function(client)
      if contain({ "html", "jsonls" }, client.name) then
        disalbeFormatting(client)
      end
      if client.server_capabilities.colorProvider then
        require("document-color").buf_attach()
      end
    end,
  })
end

local lua_ls = vim.fn.exepath("lua-language-server")
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
  capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  cmd = { lua_ls, "-E", vim.fn.fnamemodify(lua_ls, ":h:h:h") .. "/main.lua" },
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      runtime = {
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.cssls.setup({
  capabilities = capabilities,
  init_options = {
    provideFormatter = false,
  },
  settings = {
    scss = {
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = disalbeFormatting,
  settings = {
    ["rust-analyzer"] = {
      -- assist = {
      --   importMergeBehavior = "last",
      --   importPrefix = "by_self",
      -- },
      -- diagnostics = {
      --   disabled = { "unresolved-import" }
      -- },
      -- cargo = {
      --     loadOutDirsFromCheck = true
      -- },
      -- procMacro = {
      --     enable = true
      -- },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

for type, icon in pairs({ Error = " ", Warn = " ", Hint = " ", Info = " " }) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
