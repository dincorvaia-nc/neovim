return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Find the filename component and change its 'path' option
      -- 0: Just filename
      -- 1: Relative path
      -- 2: Absolute path
      -- 3: Absolute path, with tilde as the home directory
      opts.sections.lualine_c[4] = { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } }
      opts.sections.lualine_c[5] = { "filename", path = 1 }
    end,
  },
}
