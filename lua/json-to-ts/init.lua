local M = {}

function M.setup(opts)
   opts = opts or {}

   print("json to ts loaded")
   vim.keymap.set("n", "<leader>d", function()
      if opts.name then
         print("hello, " .. opts.name)
      else
         print("hello")
      end
   end, { desc = "Json to TS" })
end

return M
