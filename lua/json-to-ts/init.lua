local M = {}

function M.setup(opts)
   opts = opts or {}

   print("json to ts loaded")
   print("load 1")
   vim.keymap.set("n", "<leader>d", function()
      print("load 2")
      if opts.name then
         print("hello, " .. opts.name)
      else
         print("hello")

         print("load 3")
      end
   end, { desc = "Json to TS" })
end

return M
