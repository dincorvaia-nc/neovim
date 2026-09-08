return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        { text = "Welcome to...", align = "center" },
        function()
          -- 1. Fetch current working directory and shorten home to ~
          local cwd = vim.fn.getcwd()
          local home = os.getenv("HOME") or os.getenv("USERPROFILE")
          if home then
            cwd = cwd:gsub("^" .. vim.pesc(home), "~")
          end

          -- 2. Get only the last folder name for cleaner, readable ASCII art
          -- (Full absolute paths are usually too wide for an ASCII generator)
          local folder_name = cwd:match("([^/]+)$") or cwd

          -- 3. Check if 'figlet' is installed on your system
          local text
          if vim.fn.executable("figlet") == 1 then
            text = vim.fn.system("figlet -f slant " .. vim.fn.shellescape(folder_name))
          else
            text = cwd .. "\n\n(Tip: Install 'figlet' for ASCII art)\n"
          end

          return { text = text, align = "center", padding = 2 }
        end,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
  },
}
