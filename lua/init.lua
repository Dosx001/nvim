local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- My Suff
  "Dosx001/statusline.vim",
  "Dosx001/tabline.vim",
  "Dosx001/vim-template",
  -- Vim
  "christoomey/vim-sort-motion",
  "christoomey/vim-system-copy",
  "christoomey/vim-titlecase",
  "tommcdo/vim-exchange",
  "tpope/vim-fugitive",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "justinmk/vim-sneak",
  "Exafunction/codeium.vim",
  {
    "mattn/emmet-vim",
    ft = { "html", "typescriptreact" },
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
  },
  {
    "kana/vim-textobj-user",
    dependencies = {
      "D4KU/vim-textobj-chainmember",
      "glts/vim-textobj-comment",
      "kana/vim-textobj-indent",
    },
  },
  -- Nvim
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
  "lewis6991/gitsigns.nvim",
  "monaqa/dial.nvim",
  "NvChad/nvim-colorizer.lua",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "gennaro-tedesco/nvim-peekup",
  "stevearc/dressing.nvim",
  "nvim-tree/nvim-web-devicons",
  "rcarriga/nvim-notify",
  { "folke/neodev.nvim", config = true, ft = "lua" },
  { "stevearc/oil.nvim", config = true },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },
  {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
  {
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
  },
  {
    "neovim/nvim-lspconfig",
    priority = 1,
    dependencies = {
      "nvimtools/none-ls.nvim",
      "nvimtools/none-ls-extras.nvim",
      "mrshmllow/document-color.nvim",
      {
        "jose-elias-alvarez/typescript.nvim",
        ft = { "typescript", "typescriptreact" },
        config = true,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "HiPhish/rainbow-delimiters.nvim",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "rcarriga/cmp-dap",
      "uga-rosa/cmp-dictionary",
      "saadparwaiz1/cmp_luasnip",
      "roobert/tailwindcss-colorizer-cmp.nvim",
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      { "theHamsta/nvim-dap-virtual-text", config = true },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "anuvyklack/hydra.nvim",
    },
    ft = "python",
    config = function()
      require("dap-python").setup()
      require("py-hydra")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
})
