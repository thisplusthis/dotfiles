local M = {}

-- call from command line via 
-- :lua require'runtest'.file_path()

function M.file_path()
  local fileAbs = vim.api.nvim_buf_get_name(0)
  -- local fname = vim.fs.basename(fileAbs)
  local line_col_pair = vim.api.nvim_win_get_cursor(0) -- row is 1, column is 0 indexed
  local fnamecol = fileAbs .. ':' .. tostring(line_col_pair[1]) .. ':' .. tostring(line_col_pair[2])
  print(fnamecol)
end

-- get current word under cursor position in nvim
function M.current_word()
    local current_word = vim.call('expand','<cword>')
    print(current_word)
end

function M.buffer()
    local lineNum = vim.api.nvim__buf_stats(0)
    print(lineNum)
end

return M
