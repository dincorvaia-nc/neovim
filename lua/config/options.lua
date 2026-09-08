-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Add any additional options here
--
vim.filetype.add({
  extension = {
    cls = "apex",
    apex = "apex",
    trigger = "apex",
    soql = "soql",
    sosl = "sosl",
    xq = "xquery",
    xqm = "xquery",
    xqy = "xquery",
    xql = "xquery",
    xquery = "xquery",
    -- log = "sflog",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "apex",
  callback = function()
    vim.opt_local.suffixesadd = { ".cls", ".trigger" }
    local root = vim.fs.root(0, "sfdx-project.json")
    if not root then
      return
    end
    local f = io.open(root .. "/sfdx-project.json", "r")
    if not f then
      return
    end
    local content = f:read("*a")
    f:close()
    local ok, project = pcall(vim.json.decode, content)
    if not ok or not project.packageDirectories then
      return
    end
    for _, dir in ipairs(project.packageDirectories) do
      if dir.path then
        local base = root .. "/" .. dir.path
        local function add_dirs(parent, names)
          for name, type in vim.fs.dir(parent) do
            if type == "directory" then
              if vim.tbl_contains(names, name) then
                vim.opt_local.path:append(parent .. "/" .. name)
              else
                add_dirs(parent .. "/" .. name, names)
              end
            end
          end
        end
        add_dirs(base, { "classes", "triggers" })
      end
    end
  end,
})
