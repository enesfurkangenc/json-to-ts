local M = {}

function M.get_clipboard_content()
   local clipboard_content = vim.fn.getreg("+")
   return clipboard_content
end

function M.show_clipboard_content()
   local clipboard_content = M.get_clipboard_content()
   vim.api.nvim_put({ clipboard_content }, "c", true, true)
end

return M
