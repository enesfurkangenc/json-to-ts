local M = {}

local util = require("json-to-ts.util")

function M.setup(opts)
   opts = opts or {}

   vim.keymap.set("n", "<leader>d", function()
      util.show_clipboard_content()
      if opts.name then
         print("hello, " .. opts.name)
      else
         print("hello")
      end
   end, { desc = "Json to TS" })
end

return M
