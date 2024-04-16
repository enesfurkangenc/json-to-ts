local M = {}

local util = require("json-to-ts.util")

function M.setup(opts)
   opts = opts or {}

   vim.keymap.set("n", "<leader>h", function()
      util.convert_json_to_ts()
   end, { desc = "Json to TS" })
end

return M
