local M = {}

local util = require("json-to-ts.util")

function M.setup(opts)
   opts = opts or {}

   vim.keymap.set("n", "<leader>d", function()
      util.show_clipboard_content()
   end, { desc = "Json to TS" })
end

return M
