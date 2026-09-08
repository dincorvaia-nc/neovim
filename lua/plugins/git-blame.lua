return {
  "f-person/git-blame.nvim",
  event = "BufReadPre",
  opts = {
    enabled = true,
    message_template = " <author> - <date> - <summary>",
    date_format = "%Y-%m-%d",
    virtual_text_column = 1,
    delay = 200,
  },
}
