local jar_path = vim.fn.expand(
  "~/.config/nvim/lsps/salesforcedx-vscode/packages/salesforcedx-vscode-apex/jars/apex-jorje-lsp.jar"
)

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        apex = { "prettier" },
      },
      formatters = {
        prettier = {
          -- prettier has no built-in Apex parser; it needs prettier-plugin-apex.
          -- Point at the plugin installed in Mason's prettier package via an absolute
          -- path so it resolves regardless of the buffer's directory (prettier otherwise
          -- resolves --plugin relative to CWD and fails outside SFDX repos).
          prepend_args = function()
            local plugin = vim.fn.expand(
              "~/.local/share/nvim/mason/packages/prettier/node_modules/prettier-plugin-apex/dist/src/index.js"
            )
            if vim.fn.filereadable(plugin) == 1 then
              return { "--plugin=" .. plugin }
            end
            return {}
          end,
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "apex",
        "soql",
        "sosl",
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        apex = { "pmd" },
      },
      linters = {
        pmd = {
          rulesets = "category/apex/bestpractices.xml,category/apex/errorprone.xml,category/apex/security.xml",
          args = {
            "check",
            "--format", "sarif",
            "--rulesets", function() return require("lint.linters.pmd").rulesets end,
            "--force-language", "apex",
            "--dir",
          },
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        apex_ls = {
          apex_jar_path = jar_path,
        },
      },
    },
  },
}
