local function contain(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.colorProvider = {
	dynamicRegistration = true,
}
local servers = { "bashls", "clangd", "html", "jsonls", "prismals", "pyright", "tailwindcss", "tsserver" }
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		capabilities = capabilities,
		on_attach = function(client)
			if contain({ "html", "jsonls", "tsserver" }, client.name) then
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
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

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end,
	cmd = { lua_ls, "-E", vim.fn.fnamemodify(lua_ls, ":h:h:h") .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

lspconfig.cssls.setup({
	capabilities = capabilities,
	settings = {
		scss = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})

require("typescript").setup({})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = function(client)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false
	end,
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

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
