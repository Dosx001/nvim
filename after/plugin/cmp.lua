local cmp = require("cmp")
cmp.setup({
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
  end,
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" }),
    ["<A-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<A-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<A-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<A-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- { name = "vsnip" }, -- For vsnip users.
    { name = "luasnip" }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = "buffer" },
    { name = "dictionary", keyword_length = 2 },
    { name = "path" },
    { name = "dap" },
  }),
  formatting = {
    format = function(entry, item)
      return require("tailwindcss-colorizer-cmp").formatter(entry, item)
    end,
  },
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline("?", {
  sources = {
    { name = "buffer" },
  },
})

local cmdline
if vim.fn.systemlist("uname -r | grep WSL") then
  cmdline = { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=] }
else
  cmdline = { name = "cmdline" }
end

cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
    cmdline,
  }),
})

require("cmp_dictionary").switcher({
  spelllang = {
    en_us = "~/en.dict",
  },
})

-- cmp.setup.filetype("gitcommit", {
-- 	sources = {
-- 		{ name = "commit" },
-- 		{ name = "buffer" },
-- 		{ name = "path" },
-- 	},
-- })

-- require("cmp_commit").setup({
-- 	set = true,
-- 	format = { "<<= ", " =>>" },
-- 	length = 5,
-- 	block = { "node_modules", "__pycache__" },
-- 	word_list = "~/cmpcommit.json",
-- 	repo_list = {
-- 		{ "cmp-commit", "~/git.json" },
-- 	},
-- })
