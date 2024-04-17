local M = {}

function M.get_clipboard_content()
   local clipboard_content = vim.fn.getreg("+")
   return clipboard_content
end

function M.show_clipboard_content()
   local clipboard_content = M.get_clipboard_content()
   vim.api.nvim_put({ clipboard_content }, "c", true, true)
end

function M.window_center(input_width)
   return {
      relative = "win",
      row = vim.api.nvim_win_get_height(0) / 2 - 1,
      col = vim.api.nvim_win_get_width(0) / 2 - input_width / 2,
   }
end

function M.under_cursor(_)
   return {
      relative = "cursor",
      row = 1,
      col = 0,
   }
end

function M.input()
   local prompt = "Name"
   local default = ""

   -- Calculate a minimal width with a bit buffer
   local default_width = vim.str_utfindex(default) + 10
   local prompt_width = vim.str_utfindex(prompt) + 10
   local input_width = default_width > prompt_width and default_width
      or prompt_width

   local default_win_config = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      width = input_width,
      height = 1,
      title = prompt,
   }

   local win_config = vim.tbl_deep_extend(
      "force",
      default_win_config,
      M.under_cursor(default_win_config.width)
   )

   local buffer = vim.api.nvim_create_buf(false, true)
   local window = vim.api.nvim_open_win(buffer, true, win_config)
   vim.api.nvim_buf_set_text(buffer, 0, 0, 0, 0, { default })

   vim.cmd("startinsert")
   vim.api.nvim_win_set_cursor(window, { 1, vim.str_utfindex(default) + 1 })

   vim.keymap.set({ "n", "i", "v" }, "<cr>", function()
      local lines = vim.api.nvim_buf_get_lines(buffer, 0, 1, false)
      print(lines[1])
      vim.api.nvim_win_close(window, true)
      vim.cmd("stopinsert")
      return lines[1]
   end, { buffer = buffer })

   vim.keymap.set("n", "<esc>", function()
      vim.api.nvim_win_close(window, true)
   end, { buffer = buffer })
   vim.keymap.set("n", "q", function()
      vim.api.nvim_win_close(window, true)
   end, { buffer = buffer })
end

function M.convert_json_to_ts()
   local clipboard_content = M.get_clipboard_content()
   local input_param = M.input()
   print(input_param)
   -- local json_data = vim.fn.json_decode(clipboard_content)
   -- if not json_data then
   --    print("Hata: JSON ayrıştırılamadı")
   --    return
   -- end
   --
   -- local ts_output = "interface MyData {\n"
   -- for key, value in pairs(json_data) do
   --    -- JSON içeriğindeki kontrol karakterlerini temizle
   --    key = key:gsub("%c", "")
   --    if type(value) == "string" then
   --       value = value:gsub("%c", "")
   --       ts_output = ts_output .. "    " .. key .. ": string;\n"
   --    elseif type(value) == "number" then
   --       ts_output = ts_output .. "    " .. key .. ": number;\n"
   --    elseif type(value) == "boolean" then
   --       ts_output = ts_output .. "    " .. key .. ": boolean;\n"
   --    elseif type(value) == "table" then
   --       ts_output = ts_output .. "    " .. key .. ": any[];\n"
   --    else
   --       ts_output = ts_output .. "    " .. key .. ": any;\n"
   --    end
   -- end
   -- ts_output = ts_output .. "}\n"
   --
   -- -- Mevcut dosyanın en sonuna TypeScript çıktısını ekleyin
   vim.api.nvim_put({ input_param }, "", true, true)
end

return M
