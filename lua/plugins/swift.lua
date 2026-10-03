local sourcekit_lsp = vim.fn.trim(vim.fn.system({ "xcrun", "--find", "sourcekit-lsp" }))

return {
  -- Swift syntax trees power accurate highlighting, indentation, selections, and text objects.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "swift" },
    },
  },

  -- SourceKit-LSP ships with Xcode. Use that copy so it always matches the installed SDKs.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          mason = false,
          cmd = { sourcekit_lsp },
        },
      },
    },
  },

  -- Format Swift on demand or through LazyVim's normal formatting command.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftformat" },
      },
    },
  },

  -- Run SwiftLint after opening, saving, or leaving insert mode.
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        swift = { "swiftlint" },
      },
    },
  },

  -- Install the command-line formatter and linter used above.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "swiftformat", "swiftlint" },
    },
  },

  -- Debug Swift executables with CodeLLDB and LazyVim's DAP UI.
  -- The DAP extra is imported in lua/config/lazy.lua before custom plugins.
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "codelldb" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.configurations.swift = {
        {
          type = "codelldb",
          request = "launch",
          name = "Launch Swift executable",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/.build/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
