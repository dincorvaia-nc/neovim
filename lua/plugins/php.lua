-- PHP / Laravel. The LSP choice itself lives in config/options.lua
-- (vim.g.lazyvim_php_lsp), which the LazyVim php extra reads at load time.
return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "intelephense",
        "laravel-ls",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "blade" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          -- Default is php-only; Blade files get filetype "blade" and would otherwise
          -- have no PHP intelligence at all.
          filetypes = { "php", "blade" },
          settings = {
            intelephense = {
              environment = {
                phpVersion = "8.3",
              },
              files = {
                -- Laravel + Nova + aws-sdk-php pull in some very large generated
                -- files; the 1MB default silently skips them.
                maxSize = 5000000,
              },
              -- Extensions the Docker image provides. Without these, anything
              -- touching curl/redis/soap/imagick reads as undefined locally.
              stubs = {
                "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core",
                "csprng", "ctype", "curl", "date", "dba", "dom", "enchant",
                "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd",
                "gettext", "gmp", "hash", "iconv", "imagick", "imap", "intl",
                "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
                "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm",
                "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql", "Phar",
                "posix", "pspell", "random", "readline", "redis", "Reflection",
                "session", "shmop", "SimpleXML", "snmp", "soap", "sockets",
                "sodium", "SPL", "sqlite3", "standard", "superglobals",
                "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "xml",
                "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache",
                "zip", "zlib",
              },
            },
          },
        },
        -- Blade completion, route/view/config name resolution.
        laravel_ls = {},
      },
    },
  },
}
