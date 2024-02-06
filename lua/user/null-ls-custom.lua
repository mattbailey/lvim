local helpers = require("null-ls.helpers")
local FORMATTING = require("null-ls.methods").internal.FORMATTING
require("null-ls").register({
  --your custom sources go here
  helpers.make_builtin({
    name = "fish_indent",
    meta = {
      url = "https://fishshell.com/docs/current/cmds/fish_indent.html",
      description = "fish_indent - indenter and prettifier"
    },
    method = FORMATTING,
    filetypes = { "fish" },
    generator_opts = {
      command = "fish_indent",
      args = {},       -- put any required arguments in this table
      to_stdin = true, -- instructs the command to ingest the file from STDIN (i.e. run the currently open buffer through the linter/formatter)
    },
    factory = helpers.formatter_factory,
  })
})
