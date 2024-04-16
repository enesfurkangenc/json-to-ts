local json = require("json")

local M = {}

function M.get_clipboard_content()
   local clipboard_content = vim.fn.getreg("+")
   return clipboard_content
end

function M.show_clipboard_content()
   local clipboard_content = M.get_clipboard_content()
   vim.api.nvim_put({ clipboard_content }, "c", true, true)
end

function M.convert_json_to_ts()
   local clipboard_content = M.get_clipboard_content()
   local json_data = vim.fn.json_decode(clipboard_content)
   if not json_data then
      print("Hata: JSON ayrıştırılamadı")
      return
   end

   -- TypeScript için çıktı oluştur
   local ts_output = "interface MyData {\n"
   for key, value in pairs(json_data) do
      if type(value) == "string" then
         ts_output = ts_output .. "  " .. key .. ": string;\n"
      elseif type(value) == "number" then
         ts_output = ts_output .. "  " .. key .. ": number;\n"
      elseif type(value) == "boolean" then
         ts_output = ts_output .. "  " .. key .. ": boolean;\n"
      elseif type(value) == "table" then
         ts_output = ts_output .. "  " .. key .. ": any[];\n"
      else
         ts_output = ts_output .. "  " .. key .. ": any;\n"
      end
   end
   ts_output = ts_output .. "}\n"

   -- Mevcut dosyanın en sonuna TypeScript çıktısını ekleyin
   vim.api.nvim_put({ ts_output }, "", true, true)
end

return M
