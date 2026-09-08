return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "ruby" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          mason = false,
          init_options = {
            formatter = "standard",
            linters = { "standard" },
          },
        },
      },
    },
  },
}
